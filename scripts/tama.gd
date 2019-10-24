extends KinematicBody2D

# mouveent
export (int) var  vitesse = 200
var velocity
var sensTama = "Face"
onready var anim = get_node("sprite")

var isBloque = false

# faim
var faim = 100
onready var jaugeFaim = get_node("/root/scene/CanvasLayer/jauges/VBoxContainer/faim") #juste pour tester à cacher après
onready var timerAnimFaim #dans game manager plutôt ?
var palierFaim = 4
var paliersFaim = [0,10,30,50,80,100]
onready var timerFaim = get_node("timerFaim")

# interaction
var objetProche
var tiensQqchose = false
var isInPotager = false
var isDancing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.connect("animation_finished",self,"_anim_finished")
	timerFaim.connect("timeout",self,"gargouille")

func _input(event):
	if event.is_action_pressed("action"):
		if objetProche != null:
			objetProche.interaction()
	
	if event.is_action_pressed("test3"):
		set_faim(-20)

#### mouvement #####
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("haut"):
		velocity.y -= 1
	if Input.is_action_pressed("bas"):
		velocity.y += 1
	if Input.is_action_pressed("droite"):
		velocity.x += 1
	if Input.is_action_pressed("gauche"):
		velocity.x -= 1
	velocity = velocity.normalized() * vitesse
	
	
func _physics_process(delta):
	if !isBloque:
		get_input()
	else :
		velocity = Vector2(0,0)
	velocity = Vector2(velocity.x, velocity.y )
	velocity = move_and_slide(velocity)
	if !isDancing :
		if velocity.x == 0 && velocity.y == 0 :
			anim.play("idle"+sensTama)
		else :
			anim.play("marche"+sensTama)
		if velocity.x > 0:
			anim.flip_h = true
		else :
			anim.flip_h = false
	
func entre_zone_milieu():
	sensTama = "Dos"

func sort_zone_milieu():
	sensTama = "Face"	

##### faim ########
func set_faim(modif):
	faim = clamp(faim + modif,0,100)
	jaugeFaim.value = faim
	if faim > paliersFaim[palierFaim+1]:
		change_palier(1)
	elif faim < paliersFaim[palierFaim]:
		change_palier(-1)

func change_palier(i):
	pass
	
func gargouille():
	pass

#######  interactions ######

func proche_d_objet(obj):
	if !tiensQqchose:
		objetProche = obj

func part_d_objet(obj):
	if !tiensQqchose && obj == objetProche :
		objetProche = null
		
		
func pirouette():
	isDancing = true
	anim.play("danse")
	
func _anim_finished():
	if anim.animation == "danse":
		isDancing = false
