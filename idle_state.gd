extends State

@export var idle_speed = 0.0
@export var stopping_rate: float = 5.0

const IDLE_ANIMATION = "Idle"

func enter():
	parent.animation_player.queue(IDLE_ANIMATION)

func exit():
	parent.animation_player.stop()
	
func process_physics(delta):
	parent.velocity.x = move_toward(parent.velocity.x, 0, stopping_rate)
	parent.velocity.z = move_toward(parent.velocity.z, 0, stopping_rate)
				
