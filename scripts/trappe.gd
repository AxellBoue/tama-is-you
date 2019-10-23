extends "res://scripts/objInteractif.gd"

export (bool) var haut = true
onready var solHautEntier = get_node("/root/scene/decor/sol/sol")
onready var solHautCoupe = get_node("/root/scene/decor/sol/solCoupe")
onready var solHautColl = get_node("/root/scene/decor/sol/bordsSol")
onready var solBasColl = get_node("/root/scene/decor/sol bas/bordsSol2")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func interaction():
	if haut :
		etage_bas()
	else :
		etage_haut()
		
func etage_bas():
	solHautEntier.visible = false
	solHautCoupe.visible = true
	solHautColl.set_collision_layer_bit(0,false)
	solBasColl.set_collision_layer_bit(0,true)
	tama.position = Vector2(790,722)
	get_node("/root/scene/camera").position = Vector2(510,510)

func etage_haut():
	solHautEntier.visible = true
	solHautCoupe.visible = false
	solHautColl.set_collision_layer_bit(0,true)
	solBasColl.set_collision_layer_bit(0,false)
	tama.position = Vector2(780,519)
	get_node("/root/scene/camera").position = Vector2(510,300)