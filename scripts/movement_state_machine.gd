class_name MovementStateMachine
extends StateMachine


func init(parent: CharacterBody3D, animation_player: AnimationPlayer):
	for child in get_children():
		child.parent = parent
		child.animation_player = animation_player
		child.state_machine = self
	change_state(starting_state)

func change_state(new_state: State):
	if current_state:
		current_state.exit()
		prev_state = current_state
	current_state = new_state
	current_state.enter()
# Called when the node enters the scene tree for the first time.

func try_change_state(new_state: State):
	if current_state && current_state != new_state && !current_state.locked:
		change_state(new_state)

func validate_state_type(state: State):
	print('State passed is of type: ', state.get_class())
	print(state.get_class())
	if state.get_class() != 'MovementState':
		print('wrong state type passed')
		return false
	else:
		return true

func _process(delta):
	current_state.process_frame(delta)
	
func _physics_process(delta):
	current_state.process_physics(delta)

func process_input(event: InputEvent):
	current_state.process_input(event)
