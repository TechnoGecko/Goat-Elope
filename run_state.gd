extends State

const RUN_ANIMATION = "Running_A"

@export var running_speed = 13.0

func process_physics(delta):
	parent.move_character(running_speed)
	
func process():
	parent.animation_player.play(RUN_ANIMATION)
