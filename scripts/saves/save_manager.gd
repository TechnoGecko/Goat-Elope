extends Node

var json = JSON.new()
var path = "user://data.json"

var data = {}

func save(data):
	var file = FileAccess.open(path, FileAccess.WRITE)
	var stringified = JSON.stringify(data)
	file.close()
	file = null
	
func read_save():
	var file = FileAccess.open('path', FileAccess.READ)
	var data = json.parse(file.get_as_text())
	return data
	
func create_new_save_file():
	var file = FileAccess.open("res://scripts/saves/default_save.json", FileAccess.READ)
	var error = json.parse(file.get_as_text())
	if error == OK:
		var data = json.data
		if typeof(data) == TYPE_ARRAY:
			print('data parsed:')
			print(data)
			save(data)
		else:
			print('Error creating save file! D:')
			print(error)
	
func _ready():
	create_new_save_file()
	
