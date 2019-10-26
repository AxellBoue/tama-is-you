extends "res://scripts/objInteractif.gd"

var tenue = false
var pommierDorigine = null
var tombe = true
onready var pomme = get_node("../")
var vitesse = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if tombe:
		vitesse += 55
		pomme.move_and_slide(Vector2(120,vitesse))
		if global_position.y >= 470:
			tombe = false

func interaction():
	if !tenue : #la prends
		tenue = true
		tama.tiensQqchose = true
		pomme.get_parent().remove_child(pomme)
		tama.add_child(pomme)
		pomme.position = Vector2(0,-130)
		if pommierDorigine != null:
			pommierDorigine.pomme_prise()
			pommierDorigine = null
		#tama.proche_d_objet(self)
	else :
		if tama.isInPotager: # plante
			get_node("/root/scene/decor/sol/potager").plante(pomme)
		else : # mange
			tama.tiensQqchose = false
			tama.part_d_objet(pomme)
			tama.set_faim(get_node("/root/scene/gameManager").valeurPomme)
			tama.mange()
			get_node("/root/scene/humain").tama_mange()
			pomme.queue_free()