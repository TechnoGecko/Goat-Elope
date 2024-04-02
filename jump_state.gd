extends State

const JUMP_START_ANIMATION = "Jump_Start"
const JUMP_IDLE_ANIMATION = "Jump_Idle"
const LAND_ANIMATION = "Jump_Land"

@export var jump_height: float 
@export var variable_jump_height: float
@export var jump_time_to_peak: float 
@export var jump_time_to_descent: float 

@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var variable_jump_gravity: float = (jump_velocity * jump_velocity) / (-2.0 * variable_jump_height) 
@onready var fall_gravity: float = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

# Called when the node enters the scene tree for the first time.
func enter():
	jump()

func exit():
	animation_player.play(LAND_ANIMATION)

func jump():
	parent.velocity.y = jump_velocity
	if animation_player.current_animation != JUMP_START_ANIMATION:
		animation_player.play(JUMP_START_ANIMATION)
	parent.is_jumping = true
	
func get_jump_gravity():
	if input.is_jump_pressed():
		return variable_jump_gravity
	else:
		return jump_gravity

func process_physics(delta):
	parent.velocity.y += parent.get_gravity() * delta
