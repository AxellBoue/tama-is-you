extends "res://scripts/objInteractif.gd"

var tenue = false
var pommierDorigine = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interaction():
	if !tenue : #la prends
		tenue = true
		tama.tiensQqchose = true
		get_parent().remove_child(self)
		tama.add_child(self)
		position = Vector2(0,-50)
		if pommierDorigine != null:
			pommierDorigine.pomme_prise()
			pommierDorigine = null
		#tama.proche_d_objet(self)
	else :
		if tama.isInPotager: # plante
			get_node("/root/scene/decor/sol/potager").plante(self)
		else : # mange
			tama.tiensQqchose = false
			tama.objetProche = null
			tama.part_d_objet(self)
			tama.set_faim(get_node("/root/scene/gameManager").valeurPomme)
			get_node("/root/scene/humain").tama_mange()
			queue_free()