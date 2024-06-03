extends State
var selected_spell: Spell
var spellcast_initiated

func enter():
	selected_spell = parent.selected_spell
	var can_cast_spell = true #check mana and other requirements here
	if(can_cast_spell):
		selected_spell.


func process_physics(_delta):
	return null
