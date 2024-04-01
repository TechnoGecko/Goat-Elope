class_name PlayerController
extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $AnimationPlayer
@onready var rig = $Rig

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var walking_speed = 7.0
@export var running_speed = 13.0

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5

@export var jump_height: float 
@export var variable_jump_height: float
@export var jump_time_to_peak: float 
@export var jump_time_to_descent: float 

@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var variable_jump_gravity: float = (jump_velocity * jump_velocity) / (-2.0 * variable_jump_height) 
@onready var fall_gravity: float = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var running = false
var is_locked = false
var is_jumping = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		rig.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))

func jump():
	velocity.y = jump_velocity
	if animation_player.current_animation != 'Jump_Start':
		animation_player.play('Jump_Start')
	is_jumping = true

func playMovementAnimation():
	if is_locked:
		return
	if not is_on_floor():
		return
	running = Input.is_action_pressed('run')
	if running && animation_player.current_animation != 'Running_A':
		animation_player.play('Running_A')
	elif !running && animation_player.current_animation != 'Walking_A':
		animation_player.play('Walking_A')

func play_in_air_animation():
	if velocity.y > 0.0:
		if !animation_player.is_playing():
			animation_player.play('Jump_Idle')

func check_for_landing():
	if is_on_floor():
		is_jumping = false
		animation_player.play('Jump_Land')

func get_gravity():
	if velocity.y > 0.0:
		if Input.is_action_pressed('jump'):
			return variable_jump_gravity
		else:
			return jump_gravity
	else:
		return fall_gravity	

func _physics_process(delta): 
	if !is_jumping:
		check_for_landing()
	else:
		play_in_air_animation()
	
	if !animation_player.is_playing():
		is_locked = false
		
	if Input.is_action_just_pressed('attack'):
		if animation_player.current_animation != "Spellcast_Shoot":
			animation_player.play('Spellcast_Shoot')
			is_locked = true
	
	if Input.is_action_pressed("run"):
		SPEED = running_speed
	else:
		SPEED = walking_speed
	# Add the gravity.
	if not is_on_floor():
		print('gravity: ')
		print(get_gravity())
		print('velocity:')
		var test = get_gravity() 
		print(test)
		velocity.y += get_gravity() * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			playMovementAnimation()
		
		if !is_locked:
			rig.look_at(position + (-direction))
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if !is_locked:
			if is_on_floor():
				if animation_player.current_animation != 'Idle':
					animation_player.play('Idle')
			else:
				if animation_player.current_animation != 'Jump_Idle' && animation_player.current_animation != 'Jump_Start':
					animation_player.play('Jump_Idle')
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if !is_locked:
		move_and_slide()
