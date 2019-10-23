extends Sprite

onready var timer = get_node("Timer")
var tempsPousse
var pousse = 0

onready var pomme = preload("res://objets/pomme.tscn")

func _ready():
	timer.connect("timeout",self,"pousse")
	tempsPousse = get_node("/root/scene/gameManager").tempsPousseArbre
	timer.wait_time = tempsPousse
	timer.start()

func pousse():
	pousse += 1
	match pousse:
		1:
			pass
		2:
			pass
		3:
			pass
		_:
			pop_pomme()

func pop_pomme():
	pass	
		
