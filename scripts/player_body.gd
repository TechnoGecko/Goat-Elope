class_name PlayerController
extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $AnimationPlayer
@onready var rig = $Rig
@onready var state_machine = $state_machine
@onready var input = $InputBrain

@export var JUMP_VELOCITY = 4.5

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5

@export var idle_state: State
@export var walk_state: State
@export var run_state: State
@export var jump_state: State
@export var fall_state: State
@export var attack_state: State

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var running = false
var is_locked = false
var allow_movement = true
var is_jumping = false

var direction

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	state_machine.init(self, animation_player, input)
	
	
func rotate_body(event: InputEvent):
	rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
	rig.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
	camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))

func play_in_air_animation():
	if velocity.y > 0.0:
		if !animation_player.is_playing():
			animation_player.play('Jump_Idle')

func check_for_landing():
	if is_on_floor():
		is_jumping = false
		animation_player.play('Jump_Land')


func _physics_process(delta): 
	
	
	if !animation_player.is_playing():
		is_locked = false
		
	if Input.is_action_just_pressed('attack'):
		
	
	if is_on_floor(): 
	
		if input.jump_pressed():
			state_machine.try_change_state(jump_state)
		
		if input.attack_pressed() :
			state_machine.try_change_state(attack_state)
			
		
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
		if input.direction():
			direction = (transform.basis * Vector3(input.direction().x, 0, input.direction().y)).normalized()
			
			if is_on_floor() and !is_locked():
				if input.run_pressed():
					state_machine.try_change_state(run_state)
				else:
					state_machine.try_change_state(walk_state)
			
			rig.look_at(position + (-direction))
			
			if allow_movement:
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
		else:
			if is_on_floor():
				if !is_locked:
					state_machine.try_change_state(idle_state)
			else:
				if animation_player.current_animation != 'Jump_Idle' && animation_player.current_animation != 'Jump_Start':
					animation_player.play('Jump_Idle')
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			
	if !is_locked:
		move_and_slide()
