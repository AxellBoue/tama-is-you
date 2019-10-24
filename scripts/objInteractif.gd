extends Area2D

onready var tama = get_node("/root/scene/tama")

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered",self,"_on_body_entered")
# warning-ignore:return_value_discarded
	connect("body_exited",self,"_on_body_exited")

func _on_body_entered(body):
	if body == tama :
		tama.proche_d_objet(self)

func _on_body_exited(body):
	if body == tama :
		tama.part_d_objet(self)

func interaction():
	pass

