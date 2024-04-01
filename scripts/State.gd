class_name State
extends Node

@export
var animation_name: String

@export
var move_speed: float

var parent: PlayerController

var base_gravity: float = ProjectSettings.get_setting('physics/3d/default_gravity')


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
