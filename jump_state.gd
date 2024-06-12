extends MovementState

const JUMP_START_ANIMATION = "Jump_Start"
const JUMP_IDLE_ANIMATION = "Jump_Idle"
const LAND_ANIMATION = "Jump_Land"
var has_jumped = false
var double_jumped = false
var pre_jump_velocity


@export var jump_height: float 
@export var second_jump_height: float
@export var second_jump_variable_height: float
@export var variable_jump_height: float
@export var jump_time_to_peak: float 
@export var double_jump_time_to_peak: float
@export var jump_time_to_descent: float 
@export var in_air_movement_speed: float = 5.0

@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@onready var second_jump_velocity: float = (2.0 * second_jump_height) / double_jump_time_to_peak
@onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var variable_jump_gravity: float = (jump_velocity * jump_velocity) / (-2.0 * variable_jump_height) 
@onready var fall_gravity: float = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

# Called when the node enters the scene tree for the first time.
func enter():
	double_jumped = false
	if parent.is_grounded():
		jump()
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
	parent.animation_player.play(JUMP_START_ANIMATION, -1, 3.0)
	parent.animation_player.queue(JUMP_IDLE_ANIMATION)
	parent.is_jumping = true
	has_jumped = true
	
func second_jump():
	parent.jump(second_jump_velocity)
	parent.animation_player.play(JUMP_START_ANIMATION, -1, 3.0)
	parent.animation_player.queue(JUMP_IDLE_ANIMATION)
	double_jumped = true
	
	
func get_jump_gravity():
	if parent.jump_pressed():
		return variable_jump_gravity
	else:
		return jump_gravity
		
func in_air_move(delta):
	if parent.momentum > in_air_movement_speed:
		parent.move_character(parent.momentum)
	else:
		parent.move_character(in_air_movement_speed)
	
func process_physics(delta):
	if parent.velocity.y > 0.0:
		has_jumped = true
	
	if has_jumped && parent.is_on_floor():
		locked = false
		has_jumped = false
		double_jumped = false
	parent.velocity.y += get_gravity() * delta
	
	if parent.direction && !parent.is_grounded():
		in_air_move(delta)
	
	

func process_input(event: InputEvent):
	if parent.jump_just_pressed() && !double_jumped && !parent.is_grounded():
		print('double jumped')
		second_jump()

func process_frame(_delta):
	if parent.animation_player.is_playing() == false && parent.is_grounded():
		parent.animation_player.play(JUMP_IDLE_ANIMATION)
