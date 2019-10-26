extends KinematicBody2D

# mouvement
export (int) var  vitesse = 200
var velocity
var sensTama = "Face"
onready var anim = get_node("sprite")

var isBloque = false # pour empecher de bouger pdt certaines interactions

onready var soundPlayer = get_node("AudioStreamPlayer")

# faim
var faim = 100
onready var jaugeFaim = get_node("/root/scene/CanvasLayer/jauges/VBoxContainer/faim") #juste pour tester à cacher après
var palierFaim = 4
var paliersFaim = [-1,10,30,50,80,101]
export var frequenceGargouille = [2,5,10,15,0]
onready var timerFaim = get_node("timerFaim")
var isGargouilling = false
onready var gargouillis = preload("res://sons/VentreGargouilleV1Nul.wav")
onready var sonMange = preload("res://sons/Manger.wav")

# interaction
var objetsProche = []
var objetActif
var tiensQqchose = false
# warning-ignore:unused_class_variable
var isInPotager = false
var isDancing = false
var isHacking = false

onready var trappeHack = get_node("/root/scene/decor/zone hack")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.connect("animation_finished",self,"_anim_finished")
	timerFaim.connect("timeout",self,"gargouille")

func _input(event):
	if event.is_action_pressed("action"):
		if objetActif != null:
			objetActif.interaction()
	
	if event.is_action_pressed("test3"):
		pass
		#set_faim(-20)

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
	
	
# warning-ignore:unused_argument
func _physics_process(delta):
	if !isBloque:
		get_input()
	else :
		velocity = Vector2(0,0)
	velocity = Vector2(velocity.x, velocity.y )
	velocity = move_and_slide(velocity)
	if !isDancing && !isGargouilling && !isHacking:
		if velocity.x == 0 && velocity.y == 0 :
			anim.play("idle"+sensTama)
		else :
			anim.play("marche"+sensTama)
		if velocity.x > 0:
			anim.flip_h = false
		else :
			anim.flip_h = true
	
func entre_zone_milieu():
	sensTama = "Dos"

func sort_zone_milieu():
	sensTama = "Face"	

##### faim ########
func set_faim(modif):
	faim = clamp(faim + modif,0,100)
	jaugeFaim.value = faim
	if faim <= 0:
		get_node("/root/scene/gameManager")._game_over()
	elif faim > paliersFaim[palierFaim+1]:
		change_palier(1)
	elif faim < paliersFaim[palierFaim]:
		change_palier(-1)

func change_palier(i):
	palierFaim += i
	if palierFaim == 0:
		timerFaim.stop()
	else :
		if i == 3 :
			timerFaim.wait_time = 2
			gargouille()
			timerFaim.wait_time = frequenceGargouille[palierFaim]
		elif i < 3 :
			timerFaim.wait_time = frequenceGargouille[palierFaim]
			timerFaim.start() #recup le temps là ou il en était pour pas faire de trop grande pause?

func gargouille():
	if palierFaim <= 3 :
		if isHacking :
			stop_hack()
		isBloque = true
		isGargouilling = true
		anim.play("gargouille")
		soundPlayer.stream = gargouillis
		soundPlayer.play()
		if palierFaim < 3 :
			timerFaim.start()

#######  interactions ######

func proche_d_objet(obj):
	 #possibilité de push back si c'est le sol ? avec 2eme argument
	if !tiensQqchose:
		objetsProche.push_front(obj)
		objetActif = obj
	else :
		#objtenu : met en place 0
		objetsProche.push_back(obj) # met en 2 sauf si sol : fin

func part_d_objet(obj):
	if !(tiensQqchose && obj == objetActif) : # ou obj != objTenu # était it !tiensQQchose && obj == objtenu
		objetsProche.erase(obj)
		if objetsProche.size() >= 1:
			objetActif = objetsProche[0] #faire des ordres de priorité ? function sort qui met les pommes au début et le sol à la fin ?
		elif objetsProche.empty():
			objetActif = null
		
		
func mange():
	soundPlayer.stream = sonMange
	soundPlayer.play()
		
func pirouette():
	isDancing = true
	anim.play("danse")
	
func start_hack():
	isHacking = true
	anim.play("hack")
	isBloque = true
	anim.flip_h = false

func stop_hack():
	isHacking = false
	isBloque = false
	trappeHack.set_is_hacking(false)
	
func _anim_finished():
	if anim.animation == "danse":
		isDancing = false
	elif anim.animation == "gargouille":
		isGargouilling = false
		isBloque = false
