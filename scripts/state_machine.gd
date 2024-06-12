class_name StateMachine
extends Node

@export
var starting_state: State

var current_state: State
var prev_state: State

func init(parent: CharacterBody3D, animation_player: AnimationPlayer):
	return null

func change_state(new_state: State):
	return null

func try_change_state(new_state: State):
	return null

func _process(delta):
	return null
	
func _physics_process(delta):
	return null

func process_input(event: InputEvent):
	return null
