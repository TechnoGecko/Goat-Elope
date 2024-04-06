extends State

@export var idle_speed = 0.0

const IDLE_ANIMATION = "Idle"

func enter():
	parent.animation_player.stop()
	parent.animation_player.play(IDLE_ANIMATION)
