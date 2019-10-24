extends "res://scripts/objInteractif.gd"

var hack = 0
var vitesseHack
var isHacking = false
onready var jauge = get_node("/root/scene/CanvasLayer/jauges/VBoxContainer/hack")
onready var feedbackHack = get_node("feedback")

# Called when the node enters the scene tree for the first time.
func _ready():
	vitesseHack = get_node("/root/scene/gameManager").vitesseHack
	feedbackHack.visible = false

func _physics_process(delta):
	if isHacking:
		set_hack(vitesseHack * delta / 10)

func interaction():
	set_is_hacking(!isHacking)
	if isHacking :
		tama.start_hack()
	else :
		tama.stop_hack()

func set_is_hacking(b):
	isHacking = b
	feedbackHack.visible = isHacking
	
func _on_body_exited(body):
	if body == tama :
		tama.part_d_objet(self)
		isHacking = false
		feedbackHack.visible = isHacking

func set_hack(f):
	hack += f
	jauge.value = hack
	if hack >= 100:
		get_node("/root/scene/gameManager").victoire()