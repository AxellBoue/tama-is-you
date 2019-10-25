extends Sprite

onready var timer = get_node("Timer")
var tempsPousse
var pousse = 0
var images

onready var pomme = preload("res://objets/pomme.tscn")
var hasPomme = false
var rand = RandomNumberGenerator.new()

func _ready():
	timer.connect("timeout",self,"_pousse")
	tempsPousse = get_node("/root/scene/gameManager").tempsPousseArbre
	timer.wait_time = tempsPousse
	timer.start()
	images = [preload("res://images/arbre1.png"),preload("res://images/arbre2.png"),preload("res://images/arbre3.png"),preload("res://images/arbre4.png")]
	rand.randomize()

func _pousse():
	pousse += 1
	if pousse < 5 :
		texture = images[pousse-1]
	elif pousse == 6 :
		pop_pomme()
	elif pousse > 6 && !hasPomme:
			var r = rand.randi_range(0,2)
			if r == 2:
				pop_pomme()

func pop_pomme():
	hasPomme = true
	var p = pomme.instance()
	add_child(p)
	p.position = Vector2(45 ,-50)
	p.pommierDorigine = self
	
func pomme_prise():
	hasPomme = false
	
		
