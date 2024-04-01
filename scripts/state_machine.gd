class_name StateMachine
extends Node

@export
var starting_state: State

var current_state: State
var prev_state: State

func init(parent: PlayerController):
	for child in get_children():
		child.parent = parent
	
	change_state(starting_state)

func change_state(new_state: State):
	current_state.exit()
	current_state = new_state
	current_state.enter()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
