extends Area2D

onready var tama = get_node("/root/scene/tama")
var zoneProche
onready var arbre = preload("res://objets/pommier.tscn")
onready var sonsPlayer = get_node("AudioStreamPlayer2D")
onready var sonsPlante = [preload("res://sons/PlanterV2.wav"),preload("res://sons/PlanterV3.wav")]
var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered",self,"_on_body_entered")
# warning-ignore:return_value_discarded
	connect("body_exited",self,"_on_body_exited")
	rand.randomize()
	
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
	if zoneProche :
		tama.part_d_objet(pomme)
		pomme.queue_free()
		tama.tiensQqchose = false
		zoneProche.vide = false
		zoneProche.feedback.visible = false
		var a = arbre.instance()
		zoneProche.add_child(a)
		zoneProche = null
		sonsPlayer.stream = sonsPlante[rand.randi_range(0,1)]
		sonsPlayer.play()
		# add_child(a)
		# a.global_position = zoneProche.global_position
		# zoneProche.queue_free