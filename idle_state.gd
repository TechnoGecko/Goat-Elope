extends State

@export var idle_speed = 0.0

const IDLE_ANIMATION = "Idle"

func enter():
	parent.animation_player.queue(IDLE_ANIMATION)

func exit():
	parent.animation_player.stop()
