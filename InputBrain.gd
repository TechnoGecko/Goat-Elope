class_name InputBrain
extends Node

var player

func init(_player: PlayerController):
	player = _player


func input(event):
	if event is InputEventMouseMotion:
		player.rotate_body(event)


