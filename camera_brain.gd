extends Node3D
@export var max_camera_angle = 50.0
@export var min_camera_angle = -33.0
@export var camera_rotation_speed = .5
@export var camera_snap_speed = .05
@onready var input_brain = $"../input_brain"

var camera_was_reset = false
var camera_reset_initiated = false
var camera_rotation_weight = 0.0
var initial_camera_yaw
var target_camera_direction
var input_direction_on_camera_reset
#used for preserving input direction basis on camera reset
var prev_cam_yaw_basis
@onready var rig = $"../Rig"
@onready var cam_yaw = $CamYaw
@onready var cam_pitch = $CamYaw/CamPitch

var direction
var input_dir

func _process(delta):
	
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	if input_dir != Vector2(0.0, 0.0):
		print("input direction:")
		print(input_dir)
	#direction = (cam_yaw.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = input_brain.movement_input_dir
	
	if Input.is_action_just_pressed('reset_camera'):
		target_camera_direction = rig.rotation_degrees.y - 180
		camera_reset_initiated = true
		initial_camera_yaw = cam_yaw.rotation_degrees.y
		prev_cam_yaw_basis = cam_yaw.transform.basis
	if camera_reset_initiated:
		var rate = camera_rotation_speed
		if Input.is_action_pressed('reset_camera'):
			target_camera_direction = rig.rotation_degrees.y - 180
			rate = camera_snap_speed
		var prev = cam_yaw.rotation_degrees.y
		var rotation_speed = camera_rotation_speed
		cam_yaw.rotation_degrees.y = rad_to_deg(lerp_angle(cam_yaw.rotation.y, deg_to_rad(target_camera_direction), delta * camera_rotation_speed))
		if(cam_yaw.rotation_degrees.y < prev + 1 && cam_yaw.rotation_degrees.y > prev - 1 && !Input.is_action_pressed('reset_camera')):
			cam_yaw.rotation_degrees.y = rig.rotation_degrees.y - 180
			print('Camera reset complete')
			camera_reset_initiated = false
			if direction:
				camera_was_reset = true
				input_direction_on_camera_reset = direction	
