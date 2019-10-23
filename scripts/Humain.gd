extends Node2D

onready var anim = get_node("AnimationPlayer")
onready var timer = get_node("Timer va et viens")
var isLa = true
var isDanse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.connect("animation_finished",self,"fin_anim")
	timer.connect("timeout",self,"end_timer")
	timer.wait_time = 20
	timer.start()
	arrive()

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

func part():
	anim.play("part")
	isLa = false

func content():
	anim.play("content")
	
func pas_content():
	anim.play("pas content")

func normal ():
	anim.play("normal")

func fin_anim(a):
	if a == "content" || a == "pas content" :
		normal()
	elif a == "123 soleil":
		arrive()
