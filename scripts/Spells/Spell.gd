class_name Spell
extends Node

var parent
var mana_cost = 1;
var casting_complete = false
var time_to_cast = 0.0
var input_sequence = []

func begin_casting():
	return null

func input_rules(_direction):
	return null

func cast():
	print('Bang!')
	return null


