class_name State
extends Node

@export
var animation_name: String

var parent: PlayerController
var animation_player: AnimationPlayer
var input: InputBrain
var state_machine: StateMachine

var base_gravity: float = ProjectSettings.get_setting('physics/3d/default_gravity')
var locked = false

func enter():
	return null

func exit():
	return null
	
func process_input(_event: InputEvent):
	return null

func process_physics(_delta):
	return null

func process_frame(_delta):
	return null

