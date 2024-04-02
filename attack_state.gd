extends State

const ATTACK_ANIMATION = "Spellcast_Shoot"

func enter():
	animation_player.play(ATTACK_ANIMATION)
