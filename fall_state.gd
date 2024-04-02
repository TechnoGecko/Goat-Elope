extends State

const FALL_ANIMATION = "Jump_Idle"
const LAND_ANIMATON = "Jump_Land"

func enter():
	animation_player.play(FALL_ANIMATION)
	
