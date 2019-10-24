extends Node2D

onready var anim = get_node("AnimationPlayer")
onready var timer = get_node("Timer va et viens")
var isLa = true

onready var timerDecision = get_node("Timer decisions")
onready var ui = get_node("../ui humain")
var rand = RandomNumberGenerator.new()
var isDanse = false

var amour = 50.0
onready var jaugeAmour = get_node("/root/scene/CanvasLayer/jauges/VBoxContainer/love")
var palierAmour = 1

export var impactTamaLouche = -30
var compteTamaLouche = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.connect("animation_finished",self,"fin_anim")
	timer.connect("timeout",self,"end_timer") #timer va et viens
	timer.wait_time = 20
	timer.start()
	timerDecision.connect("timeout",self,"decide")
	rand.randomize()
	arrive()

### etat ####

func decide():
	var r = rand.randi_range(0,3)
	print (r)
	match r :
		0:
			pass # bouffe
			timerDecision.wait_time = rand.randf_range(2.5,3.5)
			timerDecision.start()
			ui.nouvelObjectif(0)
		1 :
			ui.nouvelObjectif(2)
			# re timer quand fin danse ?
		2 : 
			ui.nouvelObjectif(5)
			timerDecision.wait_time = rand.randf_range(2,3)
			timerDecision.start()
		3 : 
			ui.nouvelObjectif(1)
			timerDecision.wait_time = rand.randf_range(1.5,3)
			timerDecision.start()

func fin_danse():
	timerDecision.wait_time = rand.randf_range(2,3)
	timerDecision.start()

func set_amour(i):
	amour = clamp (amour + i,0,100)
	jaugeAmour.value = amour

func tama_is_louche():
	set_amour(impactTamaLouche)
	compteTamaLouche += 1
	match compteTamaLouche :
		1:
			pass
		2:
			pass
		3:
			pass
	
	
##### depart et arrivée
func end_timer():
	if isLa :
		if !isDanse :
			part()
	else :
		_123Soleil()

func _123Soleil():
	anim.play("123 soleil")

func arrive():
	anim.play("arrive")
	isLa = true
	timerDecision.wait_time = 5
	timerDecision.start()

func part():
	timerDecision.stop()
	anim.play("part")
	isLa = false

### réactions ####	
func content(i):
	anim.play("content")
	set_amour(i)
		
func pas_content(i):
	anim.play("pas content")
	set_amour(i)
	
func normal ():
	anim.play("normal")

func fin_anim(a):
	if a == "content" || a == "pas content" :
		normal()
	elif a == "123 soleil":
		arrive()
		
		

