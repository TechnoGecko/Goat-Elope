class_name SpellStateMachine
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

func try_change_state(new_state: State):
	if current_state && current_state != new_state && !current_state.locked:
		change_state(new_state)

func _process(delta):
	current_state.process_frame(delta)
	
func _physics_process(delta):
	current_state.process_physics(delta)

func process_input(event: InputEvent):
	current_state.process_input(event)
