extends Node2D

var danseAttendue = 0
var rand = RandomNumberGenerator.new()
var attendsDanse = false
var numPas = 0
var maxPas = 7
onready var timer = get_node("Timer")
onready var timerPause = get_node("Timer pause entre pas")
var iconesPas
onready var humain = get_node("/root/scene/humain")
var impactBonneDanse
var impactMauvaiseDanse
onready var audioPlayer = get_node("AudioStreamPlayer")
onready var sons = [preload("res://sons/Simon1.wav"),preload("res://sons/Simon2.wav"),preload("res://sons/Simon3.wav")]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"fin_pas")
	timer.wait_time = 3
	timerPause.connect("timeout",self,"nouveau_pas")
	timerPause.wait_time = 1 #change apres, juste pour premier
	rand.randomize()
	var icones = get_node("/root/scene/ui humain/icones danse")
	iconesPas = [icones.get_child(0),icones.get_child(1),icones.get_child(2)]
	var gm = get_node("/root/scene/gameManager")
	impactBonneDanse = gm.impactBonneDanse
	impactMauvaiseDanse = gm.impactMauvaiseDanse
	
func _input(event):
	if event.is_action_pressed("test3"):
		#commence_danse()
		pass
	
func commence_danse():
	humain.normal()
	position = Vector2(0,0)
	visible = true
	timerPause.start()
	timerPause.wait_time = 0.5
	
func stop_danse():
	timer.stop()
	humain.fin_danse()
	visible = false
	iconesPas[danseAttendue].visible=false
	position = Vector2(-1000,0)
	numPas = 0

func nouveau_pas():
	numPas += 1
	if numPas > maxPas :
		stop_danse()
	else :
		danseAttendue = rand.randi_range(0,2)
		iconesPas[danseAttendue].visible = true
		attendsDanse = true
		timer.start()
	
func fin_pas():
	if attendsDanse :
		mauvaise_reponse()
	iconesPas[danseAttendue].visible = false
	timerPause.start()
	
	
func tama_danse(num):
	audioPlayer.stream = sons[num]
	audioPlayer.play()
	if attendsDanse :
		attendsDanse = false
		if num == danseAttendue:
			bonne_reponse()
		else :
			mauvaise_reponse()
	
func mauvaise_reponse():
	humain.lance_reaction_later("pas content",impactMauvaiseDanse)
	
func bonne_reponse():
	humain.lance_reaction_later("content",impactBonneDanse)