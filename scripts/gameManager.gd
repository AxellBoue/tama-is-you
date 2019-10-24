extends Node2D

onready var tama = get_node("/root/scene/tama")

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
export var impactMange = 8
# warning-ignore:unused_class_variable
export var impactMangePas = -8
# warning-ignore:unused_class_variable
export var tempsRetourHumain = [10,20,30]

# Called when the node enters the scene tree for the first time.
func _ready():
	timerFaim.connect("timeout",self,"_on_timer_faim")
	timerFaim.start()

func _on_timer_faim():
	tama.set_faim(-vitesseFaim/10)

func _game_over():
	print ("gameOver")