class_name MovementState
extends State

@export
var animation_name: String

var parent: PlayerController
var animation_player: AnimationPlayer
var state_machine: MovementStateMachine 

var base_gravity: float = ProjectSettings.get_setting('physics/3d/default_gravity')
