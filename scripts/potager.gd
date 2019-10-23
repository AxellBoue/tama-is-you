extends Area2D

onready var tama = get_node("/root/scene/tama")
var zonesPlante
var zonesPrises = [false,false,false,false,false]

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_entered")
	connect("body_exited",self,"_on_body_exited")
	zonesPlante = [get_node("zonePousse"),get_node("zonePousse2"),get_node("zonePousse3"),get_node("zonePousse4"),get_node("zonePousse5")]

func _on_body_entered(body):
	if body == tama :
		tama.isInPotager = true

func _on_body_exited(body):
	if body == tama :
		tama.isInPotager = false

func plante():
	# zone la plus proche / ou zones assez proches, array
	pass