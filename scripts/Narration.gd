extends Node2D

onready var anim = get_node("AnimationPlayer")
onready var audioPlayer = get_node("AudioStreamPlayer")
onready var antenneAnim = get_node("../decor/antenne/AnimationPlayer")
onready var timer = get_node("Timer debut")

var isNuit = false
var nuits = 0
#var premierMessageEu = false
onready var hack = get_node("../decor/zone hack")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"debut_narration")
	timer.wait_time = 4
	antenneAnim.connect("animation_finished",self,"fin_anim")
	
func _physics_process(delta):
	if isNuit:
		pass

func debut_nuit():
	isNuit = true
	timer.start()

func humain_va_arriver():
	pass
	
func debut_narration():
	if nuits == 0:
		antenneAnim.play("entenne clignotte")
		anim.play("1 salut tamarade")
	nuits += 1


func fin_anim():
	antenneAnim.stop()
	pass