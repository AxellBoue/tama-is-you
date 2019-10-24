extends Area2D

var vide = true
onready var potager = get_parent()
onready var feedback = get_node("feedback")
# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered",self,"_on_body_entered")
# warning-ignore:return_value_discarded
	connect("body_exited",self,"_on_body_exited")
	
func _on_body_entered(body):
	if body.name == "tama" && body.tiensQqchose && vide:
		potager.entre_zone(self)
		feedback.visible = true

func _on_body_exited(body):
	if body.name == "tama" && vide:
		potager.sort_zone(self)
		feedback.visible = false
