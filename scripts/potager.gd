extends Area2D

onready var tama = get_node("/root/scene/tama")
#var zonesPlante
#var zonesPrises = [false,false,false,false,false]
var zoneProche
onready var arbre = preload("res://objets/pommier.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_entered")
	connect("body_exited",self,"_on_body_exited")
	
func _on_body_entered(body):
	if body == tama :
		tama.isInPotager = true

func _on_body_exited(body):
	if body == tama :
		tama.isInPotager = false

func entre_zone(zone):
	zoneProche = zone
	pass

func sort_zone(zone):
	if zone == zoneProche :
		zoneProche = null

func plante(pomme):
	print("plante ???")
	if zoneProche :
		print("plante")
		tama.part_d_objet(pomme)
		pomme.queue_free()
		tama.tiensQqchose = false
		zoneProche.vide = false
		zoneProche.feedback.visible = false
		var a = arbre.instance()
		zoneProche.add_child(a)