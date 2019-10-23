extends Node2D

var danseAttendue = 0
var rand = RandomNumberGenerator.new()
var attendsDanse = false
var numPas = 0
var maxPas = 10
onready var timer = get_node("Timer")
var iconesPas
onready var humain = get_node("/root/scene/humain")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"nouveau_pas")
	rand.randomize()
	var icones = get_node("/root/scene/ui humain/icones danse")
	iconesPas = [icones.get_child(0),icones.get_child(1),icones.get_child(2)]
	timer.wait_time = 1
	
func _input(event):
	if event.is_action_pressed("test3"):
		#commence_danse()
		pass
	
func commence_danse():
	humain.normal()
	humain.isDanse = true
	position = Vector2(0,0)
	visible = true
	timer.start()
	timer.wait_time = 3
	
func stop_danse():
	timer.stop()
	humain.isDanse = false
	visible = false
	iconesPas[danseAttendue].visible=false
	position = Vector2(-1000,0)
	numPas = 0

func nouveau_pas():
	if attendsDanse :
		mauvaise_reponse()
	numPas += 1
	if numPas > maxPas :
		stop_danse()
	else :
		iconesPas[danseAttendue].visible= false
		danseAttendue = rand.randi_range(0,2)
		iconesPas[danseAttendue].visible = true
		attendsDanse = true
	
func tama_danse(num):
	if attendsDanse :
		attendsDanse = false
		if num == danseAttendue:
			bonne_reponse()
		else :
			mauvaise_reponse()
	
func mauvaise_reponse():
	humain.pas_content()
	
func bonne_reponse():
	humain.content()