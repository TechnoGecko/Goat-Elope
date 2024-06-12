extends MovementState

@export var walking_speed = 7.0

const WALK_ANIMATION = 'Walking_A'

func enter():
	if parent.animation_player.is_playing():
		parent.animation_player.queue(WALK_ANIMATION)
	else:
		parent.animation_player.play(WALK_ANIMATION)
func exit():
	parent.animation_player.stop()

func process_physics(_delta):
	parent.move_character(walking_speed)
	parent.momentum = walking_speed
