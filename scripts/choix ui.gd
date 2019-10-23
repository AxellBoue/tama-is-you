extends Label

var fleche

# Called when the node enters the scene tree for the first time.
func _ready():
	fleche = get_node("../fleche "+name)
	fleche.set_self_modulate(Color(0,0,0,0))

func _on_focus_entered():
	fleche.set_self_modulate(Color(0,0,0,1))

func _on_focus_exited():
	fleche.set_self_modulate(Color(0,0,0,0))

