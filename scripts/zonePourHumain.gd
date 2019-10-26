extends Area2D

onready var tama = get_node("/root/scene/tama")

func _ready():
	connect("body_entered",self,"_on_body_entered")
	connect("body_exited",self,"_on_body_exited")

func _on_body_entered(body):
	if body == tama :
		tama.entre_zone_milieu()

func _on_body_exited(body):
	if body == tama :
		tama.sort_zone_milieu()