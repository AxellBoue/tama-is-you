extends Node2D

onready var tama = get_node("/root/scene/tama")

#faim
export (float) var vitesseFaim = 5
export var valeurPomme = 30
export var valeurSnack = 10
onready var timerFaim = get_node("timerFaim")
export (float) var tempsPousseArbre = 10
#hack
export (float) var vitesseHack = 10
#danse
export (float) var vitesseDanse = 2.5
# love
export var impactBonneDanse = 5
export var impactMauvaiseDanse = -5
export var tempsRetourHumain = [10,20,30]

# Called when the node enters the scene tree for the first time.
func _ready():
	timerFaim.connect("timeout",self,"_on_timer_faim")
	timerFaim.start()

func _on_timer_faim():
	tama.set_faim(-vitesseFaim/10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
