extends "res://scripts/objInteractif.gd"

var tenue = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interaction():
	if !tenue :
		tenue = true
		tama.tiensQqchose = true
		get_parent().remove_child(self)
		tama.add_child(self)
		position = Vector2(0,-50)
		#tama.proche_d_objet(self)
	else :
		if tama.isInPotager: # plante
			get_node("/root/scene/decor/sol/potager").plante(self)
		else : # mange
			tama.tiensQqchose = false
			tama.part_d_objet(self)
			tama.set_faim(get_node("/root/scene/gameManager").valeurPomme)
			queue_free()