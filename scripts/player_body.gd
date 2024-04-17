class_name PlayerController
extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $AnimationPlayer
@onready var rig = $Rig
@onready var state_machine = $state_machine
@onready var input_brain = $InputBrain

@export var momentum_decay_rate: float = 0.1

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5
@export var joystick_sens_horizontal = 0.5
@export var joystick_sens_vertical = 0.5
@export var max_camera_angle = 45.0
@export var min_camera_angle = -33.0

@export var idle_state: State
@export var walk_state: State
@export var run_state: State
@export var jump_state: State
@export var fall_state: State
@export var attack_state: State
@export var spellcast_state: State
@export var spell_select_state: State


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var running = false
var is_locked = false
var allow_movement = true
var is_jumping = false

var direction
var right_stick_direction
var override_right_stick = false
var momentum = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	state_machine.init(self, animation_player, input_brain)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_body(event)
		
	state_machine.process_input(event)
	
func jump_pressed():
	if Input.is_action_pressed("jump"):
		return true
	return false

func jump_just_pressed():
	if Input.is_action_just_pressed("jump"):
		return true
	return false
		
func jump(jump_velocity):
	velocity.y = jump_velocity
	
func is_grounded():
	return is_on_floor()
	
func run_pressed():
	if Input.is_action_pressed("run"):
		return true
	return false

func attack_pressed():
	if Input.is_action_pressed("attack"):
		return true
	return false

func rotate_body(event: InputEvent):
	rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
	rig.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
	camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))

func rotate_body_joystick(input_direction):
	rotate_y(deg_to_rad(-input_direction.x * joystick_sens_horizontal))
	rig.rotate_y(deg_to_rad(input_direction.x * joystick_sens_horizontal))
	if input_direction.y < 0 && camera_mount.transform.basis.get_rotation_quaternion()[2] > -0.45:
		camera_mount.rotate_x( deg_to_rad(-input_direction.y * joystick_sens_vertical))
	elif input_direction.y > 0 && camera_mount.transform.basis.get_rotation_quaternion()[2] < 0.33:
		camera_mount.rotate_x( deg_to_rad(-input_direction.y * joystick_sens_vertical))
		
	
func play_in_air_animation():
	if velocity.y > 0.0:
		if !animation_player.is_playing():
			animation_player.play('Jump_Idle')

func check_for_landing():
	if is_on_floor():
		is_jumping = false
		animation_player.play('Jump_Land')

func move_character(movement_speed):
	if allow_movement:
		velocity.x = direction.x * movement_speed
		velocity.z = direction.z * movement_speed

func decay_momentum():
	if momentum > 0.1:
		momentum = momentum * momentum_decay_rate
	else:
		momentum = 0.0

func _process(delta):
	var input_dir_right = Input.get_vector("right_stick_left", "right_stick_right", "right_stick_up", "right_stick_down")
	right_stick_direction =  Vector3(input_dir_right.x, input_dir_right.y, 0)
	
	if right_stick_direction && !override_right_stick:
		rotate_body_joystick(right_stick_direction)
		print('right stick direction:')
		print(right_stick_direction)
	
	if !animation_player.is_playing():
		is_locked = false
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if !is_locked && direction:
		rig.look_at(position + (-direction))
	
	if is_on_floor():
		if !is_locked:
			if jump_just_pressed():
				state_machine.try_change_state(jump_state)
			elif direction:
				if animation_player.current_animation != 'Jump_Land':
					if run_pressed():
						state_machine.try_change_state(run_state)
					else:
						state_machine.try_change_state(walk_state)
			else:
				
				state_machine.try_change_state(idle_state)
	else:
		state_machine.try_change_state(jump_state) 
			
	if !is_locked:
		move_and_slide()
