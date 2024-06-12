extends Node
@onready var cam_yaw = $"../camera_mount/CamYaw"
@onready var player = $".."
@onready var movement_state_machine = $"../movement_state_machine"


@export var movement_input_dir = Vector2(0.0, 0.0)
@export var right_stick_direction = Vector2(0.0, 0.0)
@export var input_dir = Vector3(0.0, 0.0, 0.0)
@export var d_pad_dir = Vector2(0.0, 0.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_input_directions():
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	if input_dir != Vector2(0.0, 0.0):
		print("input direction:")
		print(input_dir)
	movement_input_dir = (cam_yaw.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var input_dir_right = Input.get_vector("right_stick_left", "right_stick_right", "right_stick_up", "right_stick_down")
	right_stick_direction =  Vector3(input_dir_right.x, input_dir_right.y, 0)
	
	var input_d_pad = Input.get_vector("d_pad_left", "d_pad_right", "d_pad_up", "d_pad_down")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_input_directions()

func _input(event):
	if event is InputEventMouseMotion:
		player.rotate_body(event)
		
	movement_state_machine.process_input(event)
