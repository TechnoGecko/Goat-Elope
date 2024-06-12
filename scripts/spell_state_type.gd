class_name SpellState
extends State

@export
var animation_name: String

var parent: PlayerController
var animation_player: AnimationPlayer
var state_machine: SpellStateMachine 
var input_sequence = Array()
var input_sequence_time_limit: float
var input_complete = false
var timer_running = false



func start_input_sequence():
	if(!timer_running):
		timer_running = true
		await get_tree().create_timer(input_sequence_time_limit)
		timer_running = false
	else:
		print('tried to start input sequence while timer was already running')
		return null

func process_input_sequence(input: InputEvent):
	return true
		
func reset_input_sequence():
	return null
	
func _input(event):
	#if !timer_running:
		
	while timer_running:
		if process_input_sequence(event):
			input_complete = true
			
		
