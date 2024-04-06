extends State

@export var walking_speed = 7.0

const WALK_ANIMATION = 'Walking_A'

func process_physics(delta):
	parent.move_character(walking_speed)

func process_frame(delta):
	if parent.animation_player.current_animation != WALK_ANIMATION:
		parent.animation_player.play(WALK_ANIMATION)
