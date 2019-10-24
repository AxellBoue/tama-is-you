extends Node2D

#humain
onready var humain = get_node("../humain")

var focus
# navigation dans les icones du haut
var icones 
var currentI
var i_target
var direction = 1
onready var timerUi = get_node("TimerBougeDansUi")
export var tpsChangeIcone = 0.7
# navigation sous menu
var choisiTexte = false

#partie de l'ui qui est en canvas et pas en image (pour le texte) 
onready var ecran = get_node("/root/scene/Ecran/texteMilieu")

# danse
onready var menuDanse = ecran.get_node("menuDanse")
onready var dancefloor = get_node("/root/scene/decor/sol/dancefloor")

# manger
onready var menuBouffe = ecran.get_node("menuBouffe")
onready var positionPopBouffe = get_node("/root/scene/decor/pop bouffe")
onready var pomme = preload ("res://objets/pomme.tscn")
onready var snack = preload ("res://objets/snack.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	icones = [get_node("icones haut/manger"),get_node("icones haut/lumiere"),
	get_node("icones haut/jeu"),get_node("icones haut/soin"),
	get_node("icones bas/lumiere2"),get_node("icones bas/lumiere"),
	get_node("icones bas/jeu2"),get_node("icones bas/soin")]
	timerUi.connect("timeout",self,"_bouge_dans_ui")
	timerUi.wait_time = tpsChangeIcone

func _input(event):
	pass
	if event.is_action_pressed("test3"):
		nouvelObjectif(0)
	#if event.is_action_pressed("test2"):
	#	nouvelObjectif(5)
	#if event.is_action_pressed("test3"):
	#	nouvelObjectif(2)	


func nouvelObjectif (var new_i):
	#if new_i == 0:
		#humain.timerDecision.stop()
	i_target = new_i
	if currentI == null :
		change_focus_icones(0)
	if i_target == currentI :
		#active_action()
		timerUi.start() #pour qu'il y ait un délais si c'est 0 et que la current i était null
	else :
		if i_target < currentI :
			direction = -1
		elif i_target > currentI:
			direction = 1
		timerUi.start()
	
func _bouge_dans_ui():
	if i_target == currentI :
		if !choisiTexte :
			active_action()
		else :
			change_focus_texte()
	else :
		change_focus_icones(currentI + direction)
	
func change_focus_icones(var new_f):
	if currentI != null:
		icones[currentI]._on_focus_exit()
	currentI = new_f
	icones[currentI]._on_focus_enter()
	focus = icones[currentI]

func change_focus_texte():
	active_action()


func active_action():
	timerUi.stop()
	match focus.name : 
		"manger" :
			menuBouffe.visible = true
			menuBouffe.get_node("repas")._on_focus_entered()
			focus = menuBouffe.get_node("repas")
			choisiTexte = true
			timerUi.start()
		"repas":
			choisiTexte = false
			pop_bouffe(pomme)
			menuBouffe.visible = false
			focus = icones[currentI]
		"snack":
			choisiTexte = false
			pop_bouffe(snack)
			focus = icones[currentI]
		"lumiere" :
			humain.fin_hesite()
		"jeu" :
			menuDanse.visible = true
			menuDanse.get_node("danse")._on_focus_entered()
			focus = menuDanse.get_node("danse")
			choisiTexte = true
			timerUi.start()
		"danse":
			choisiTexte = false
			dancefloor.commence_danse()
			menuDanse.visible = false
			focus = icones[currentI]
		"soin" :
			humain.fin_hesite()
		_ :
			humain.fin_hesite()
			
# actions
func pop_bouffe(typeDeBouffe):
	var newBouffe = typeDeBouffe.instance()
	positionPopBouffe.get_node("../").add_child(newBouffe)
	newBouffe.global_position = positionPopBouffe.global_position
	humain.donne_bouffe()
