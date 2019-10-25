extends Node2D

onready var tama = get_node("/root/scene/tama")
onready var camera = get_node("../camera")
onready var menu = get_node("/root/scene/CanvasLayer/menu")
onready var recommencer = menu.get_node("CenterContainer/VBoxContainer/recommencer")
onready var quitter = menu.get_node("CenterContainer/VBoxContainer/quitter")

#faim
export (float) var vitesseFaim = 5
# warning-ignore:unused_class_variable
export var valeurPomme = 30
# warning-ignore:unused_class_variable
export var valeurSnack = 10
onready var timerFaim = get_node("timerFaim")
# warning-ignore:unused_class_variable
export (float) var tempsPousseArbre = 8
#hack
# warning-ignore:unused_class_variable
export (float) var vitesseHack = 10
#danse
# warning-ignore:unused_class_variable
export (float) var vitesseDanse = 2.5
# love
# warning-ignore:unused_class_variable
export var impactBonneDanse = 5
# warning-ignore:unused_class_variable
export var impactMauvaiseDanse = -5
# warning-ignore:unused_class_variable
export var tempsRetourHumain = [10,20,30]
# vie
export var nombreCoupsPourCasser = 6
var vieTama 
#onready var feedbackCasse

# Called when the node enters the scene tree for the first time.
func _ready():
	timerFaim.connect("timeout",self,"_on_timer_faim")
	timerFaim.start()
	recommencer.connect("pressed",self,"_recommencer")
	quitter.connect("pressed",self,"_quitter")
	vieTama = nombreCoupsPourCasser

func _on_timer_faim():
	tama.set_faim(-vitesseFaim/10)

##### casse le tama  ######
func frappe():
	vieTama -= 1
	camera.get_node("AnimationPlayer").play("secoue")
	if vieTama <= 0 :
		_game_over()
	#else :
		#feedbackVie[vieTama].visible = true


##### game over  #######
func _game_over():
	menu.get_node("AnimationPlayer").play("game over")
	recommencer.grab_focus()

func victoire():
	menu.get_node("AnimationPlayer").play("victoire")
	recommencer.grab_focus()

func _recommencer():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	
func _quitter():
	get_tree().quit()
