extends MovementState

const FALL_ANIMATION = "Jump_Idle"
const LAND_ANIMATON = "Jump_Land"

func enter():
	parent.animation_player.play(FALL_ANIMATION)
	
