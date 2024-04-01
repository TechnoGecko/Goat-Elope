extends Node

@onready var player = $".."


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func input(event):
	if event is InputEventMouseMotion:
		player.rotate_body(event)
	
func jump_pressed():
	if Input.is_action_pressed("jump"):
		return true
	return false

func jump_just_pressed():
	if Input.is_action_just_pressed("jump"):
		return true
	return false
		
func run_pressed():
	if Input.is_action_pressed("run"):
		return true
	return false

func attack_pressed():
	if Input.is_action_pressed("attack"):
		return true
	return false

func direction():
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	return input_dir
