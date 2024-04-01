extends State

@export var walking_speed = 7.0

func enter():
	
	
func playMovementAnimation():
	if parent.is_locked:
		return
	if not is_on_floor():
		return
	running = Input.is_action_pressed('run')
	if running && animation_player.current_animation != 'Running_A':
		animation_player.play('Running_A')
	elif !running && animation_player.current_animation != 'Walking_A':
		animation_player.play('Walking_A')

func process_physics(delta):
	