class_name State
extends Node

@export
var animation_name: String

var parent: PlayerController
var animation_player: AnimationPlayer
var input: InputBrain

var base_gravity: float = ProjectSettings.get_setting('physics/3d/default_gravity')
var locked = false

func enter():
	return null

func exit():
	return null
	
func process_input(event: InputEvent):
	return null

func process_physics(delta):
	return null

func process_frame(delta):
	return null

