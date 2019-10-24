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

# interaction
var objetProche
var tiensQqchose = false
var isInPotager = false
var isDancing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.connect("animation_finished",self,"_anim_finished")

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
			anim.play("marche")
	
	
##### faim ########
func set_faim(modif):
	faim = clamp(faim + modif,0,100)
	jaugeFaim.value = faim

func change_palier(i):
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
