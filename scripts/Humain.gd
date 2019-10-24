extends Node2D

onready var gm = get_node("/root/scene/gameManager")

onready var anim = get_node("AnimationPlayer")
onready var timer = get_node("Timer va et viens")
var isLa = true
var vaPartir = false

onready var timerDecision = get_node("Timer decisions")
onready var ui = get_node("../ui humain")
var rand = RandomNumberGenerator.new()
var isDanse = false

var amour = 50.0
onready var jaugeAmour = get_node("/root/scene/CanvasLayer/jauges/VBoxContainer/love")
var palierAmour = 1
export var paliersAmour = [0,30,60,100]
export var tempsRetourParPalier = [60,30,10]
export var tempsResteParPalier = [15,30,50]
var compteurFrappe = 2
# tempsRetourSiFaim

export var impactTamaLouche = -30
var compteTamaLouche = 0

onready var timerBouffe = get_node("TimerBouffe")
var aBoufe = false
export var impactMange = 8
export var impactMangePas = -8
export var delaisPourManger = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.connect("animation_finished",self,"fin_anim")
	timer.connect("timeout",self,"end_timer_va_et_viens") #timer va et viens
	timer.wait_time = tempsRetourParPalier[palierAmour]
	timer.start()
	timerDecision.connect("timeout",self,"decide")
	timerBouffe.connect("timeout",self,"fin_timer_bouffe")
	timerBouffe.wait_time = delaisPourManger
	rand.randomize()
	arrive()

func _input(event):
	pass
	if event.is_action_pressed("test1"):
		pas_content(-5)
	if event.is_action_pressed("test2"):
		content(5)

### etat ####

func decide():
	var r = rand.randi_range(0,3)
	print (r)
	match r :
		0:
			# bouffe
			timerDecision.wait_time = rand.randf_range(3.5,4.5)
			ui.nouvelObjectif(0)
		1 :
			# danse
			ui.nouvelObjectif(2)
		2 : 
			ui.nouvelObjectif(rand.randi_range(3,5))
			timerDecision.wait_time = rand.randf_range(1,1.5)
			#timerDecision.start()
		3 : 
			ui.nouvelObjectif(1)
			timerDecision.wait_time = rand.randf_range(1,1.5)
			#timerDecision.start()

func fin_danse():
	if vaPartir :
		part()
	else :
		timerDecision.wait_time = rand.randf_range(2,3)
		timerDecision.start()
	
func fin_hesite():
	timerDecision.start()

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
func end_timer_va_et_viens():
	if isLa :
		if !isDanse : #et pas entrain de donner a manger
			part()
		else :
			vaPartir = true
	else :
		_123Soleil()

func _123Soleil():
	anim.play("123 soleil")

func arrive():
	anim.play("arrive")
	isLa = true
	timerDecision.wait_time = 5
	timerDecision.start()
	timer.wait_time = tempsResteParPalier[palierAmour]
	timer.start()

func part():
	timerDecision.stop()
	anim.play("part")
	isLa = false
	timer.wait_time = tempsRetourParPalier[palierAmour]
	timer.start()
	vaPartir = false
	
	
##### gestion bouffe #####
func donne_bouffe():
	timerBouffe.start() # pour su'il s'énerve si mange pas
	timerDecision.start() # pour l'action suivante de l'humain

func fin_timer_bouffe():
	pas_content(impactMangePas)
	print ("pas mangé")

func tama_mange():
	timerBouffe.stop()


####  amour  et colère ####
func set_amour(i):
	amour = clamp (amour + i,0,100)
	jaugeAmour.value = amour
	if amour < paliersAmour[palierAmour]:
		set_palier_amour(-1)
	elif amour > paliersAmour[palierAmour]:
		set_palier_amour(1)

func set_palier_amour(i):
	palierAmour += i
	#print(palierAmour)
	
func frappe():
	gm.frappe()

### réactions ####	
func content(i):
	anim.play("content")
	set_amour(i)
		
func pas_content(i):
	anim.play("pas content")
	set_amour(i)
	if palierAmour == 0:
		if compteurFrappe >= 2:
			frappe()
			compteurFrappe = 0
		else :
			compteurFrappe += 1
		 
func normal ():
	anim.play("normal")

func fin_anim(a):
	if a == "content" || a == "pas content" :
		normal()
	elif a == "123 soleil":
		arrive()
		
		

