extends "res://scripts/objInteractif.gd"

onready var dancefloor = get_parent()
export (int) var num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interaction():
	dancefloor.tama_danse(num)
	tama.pirouette()
