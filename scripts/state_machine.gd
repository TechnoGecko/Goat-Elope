class_name StateMachine
extends Node

@export
var starting_state: State

var current_state: State
var prev_state: State

func init(parent: PlayerController, animation_player: AnimationPlayer, input: InputBrain ):
	for child in get_children():
		child.parent = parent
		child.animation_player = animation_player
		child.input: input
	change_state(starting_state)

func change_state(new_state: State):
	current_state.exit()
	prev_state = current_state
	current_state = new_state
	current_state.enter()
# Called when the node enters the scene tree for the first time.

func try_change_state(new_state: State):
	if current_state != new_state:
		current_state = new_state

func _process(delta):
	current_state.process()
