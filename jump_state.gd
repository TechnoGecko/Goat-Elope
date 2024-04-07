extends State

const JUMP_START_ANIMATION = "Jump_Start"
const JUMP_IDLE_ANIMATION = "Jump_Idle"
const LAND_ANIMATION = "Jump_Land"
var has_jumped = false

@export var jump_height: float 
@export var variable_jump_height: float
@export var jump_time_to_peak: float 
@export var jump_time_to_descent: float 
@export var in_air_movement_speed: float = 5.0

@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var variable_jump_gravity: float = (jump_velocity * jump_velocity) / (-2.0 * variable_jump_height) 
@onready var fall_gravity: float = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

# Called when the node enters the scene tree for the first time.
func enter():
	print('jump entered')
	if parent.is_grounded():
		jump()
		parent.animation_player.play(JUMP_START_ANIMATION, -1, 3.0)
		parent.animation_player.queue(JUMP_IDLE_ANIMATION)
	else:
		parent.animation_player.play(JUMP_IDLE_ANIMATION)

func exit():
	parent.animation_player.play(LAND_ANIMATION, -1, 2.5)

func get_gravity():
	if parent.velocity.y >= 0:
		if Input.is_action_pressed("jump"):
			return variable_jump_gravity
		else:
			return jump_gravity
	else:
		return fall_gravity

func jump():
	locked = true
	parent.jump(jump_velocity)
	if animation_player.current_animation != JUMP_START_ANIMATION:
		parent.animation_player.play(JUMP_START_ANIMATION)
	parent.is_jumping = true
	
func get_jump_gravity():
	if input.is_jump_pressed():
		return variable_jump_gravity
	else:
		return jump_gravity

func process_physics(delta):
	if parent.velocity.y > 0.0:
		has_jumped = true
	
	if has_jumped && parent.is_on_floor():
		locked = false
		has_jumped = false
	parent.velocity.y += get_gravity() * delta
	
	if parent.direction && !parent.is_grounded():
		parent.move_character(in_air_movement_speed)

func process_frame(_delta):
	if parent.animation_player.is_playing() == false && parent.is_grounded():
		parent.animation_player.play(JUMP_IDLE_ANIMATION)
