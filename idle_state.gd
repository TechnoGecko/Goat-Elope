extends State

const IDLE_ANIMATION = "Idle"

func enter():
	animation_player.play(IDLE_ANIMATION)
