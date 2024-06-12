extends MovementState

const RUN_ANIMATION = "Running_A"

@export var running_speed = 13.0

func enter():
	if parent.animation_player.is_playing():
		parent.animation_player.queue(RUN_ANIMATION)
	else:
		parent.animation_player.play(RUN_ANIMATION)
		
func exit():
	parent.animation_player.stop()

func process_physics(delta):
	parent.move_character(running_speed)
	parent.momentum = running_speed
	
