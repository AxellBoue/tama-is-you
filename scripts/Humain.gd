extends Node2D

onready var gm = get_node("/root/scene/gameManager")

onready var anim = get_node("AnimationPlayer")
onready var timer = get_node("Timer va et viens")
var isLa = true
var vaPartir = false

onready var timerDecision = get_node("Timer decisions")
onready var ui = get_node("../ui humain")
var rand = RandomNumberGenerator.new()

var amour = 50.0
onready var jaugeAmour = get_node("/root/scene/CanvasLayer/jauges/VBoxContainer/love")
var palierAmour = 1
export var paliersAmour = [0,30,60,100]
export var tempsRetourParPalier = [60,30,10]
export var tempsResteParPalier = [15,20,50]
export (float) var tempsAjouteSiContent = 1.0
export (float) var tempsRetireSiPasContent = 1.0
var compteurFrappe = 2
# ajouter : tempsRetourSiFaim
var timerDepart
var compteurDepart = 0
var tempsDepart = 20
onready var jaugeDepart = get_node("/root/scene/CanvasLayer/jauges/VBoxContainer/tps depart")

export var impactTamaLouche = -30
var compteTamaLouche = 0

onready var timerBouffe = get_node("TimerBouffe")
export var impactMange = 8
export var impactMangePas = -8
export var delaisPourManger = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.connect("animation_finished",self,"fin_anim")
	#viens et part
	timer.connect("timeout",self,"end_timer_va_et_viens") #timer va et viens / ou juste viens
	timer.wait_time = tempsRetourParPalier[palierAmour]
	timer.start()
	timerDepart = Timer.new()
	add_child(timerDepart)
	timerDepart.wait_time = 1
	timerDepart.connect("timeout",self,"_chrono_depart")
	# actions
	timerDecision.connect("timeout",self,"decide")
	timerBouffe.connect("timeout",self,"fin_timer_bouffe")
	timerBouffe.wait_time = delaisPourManger
	rand.randomize()
	arrive()

func _input(event):
	pass
	if event.is_action_pressed("test1"):
		pas_content(impactMangePas)
	if event.is_action_pressed("test2"):
		content(impactMange)

### etat ####

func decide():
	if vaPartir :
		part()
	else :
		var r = rand.randi_range(0,5)
		match r :
			0:
				# bouffe
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
			4:
				# bouffe
				timerDecision.wait_time = rand.randf_range(3.5,4.5)
				ui.nouvelObjectif(0)
			5 :
				# danse
				ui.nouvelObjectif(2)

func fin_danse():
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
func end_timer_va_et_viens(): # juste pour viens
	_123Soleil()
	timer.stop()

func _123Soleil():
	anim.play("123 soleil")

func arrive():
	anim.play("arrive")
	isLa = true
	timerDecision.wait_time = 5
	timerDecision.start()
	tempsDepart = tempsResteParPalier[palierAmour]
	jaugeDepart.max_value = tempsDepart
	timerDepart.start()
	timer.stop()

func _chrono_depart():
	compteurDepart += 1
	jaugeDepart.value = compteurDepart
	if compteurDepart >= tempsDepart :
		vaPartir = true
		

func part():
	timerDecision.stop()
	timerDepart.stop()
	compteurDepart = 0
	jaugeDepart.value = compteurDepart
	anim.play("part")
	isLa = false
	timer.wait_time = tempsRetourParPalier[palierAmour]
	timer.start()
	vaPartir = false
	
	
##### gestion bouffe #####
func donne_bouffe():
	timerBouffe.start() # pour su'il s'énerve si mange pas
	timerDecision.wait_time = rand.randf_range(delaisPourManger + 0.5,delaisPourManger + 1.5) 
	timerDecision.start() # pour l'action suivante de l'humain

func fin_timer_bouffe():
	pas_content(impactMangePas)
	#print ("pas mangé")

func tama_mange():
	timerBouffe.stop()
	if isLa :
		content(impactMange)


####  amour  et colère ####
func set_amour(i):
	amour = clamp (amour + i,0,100)
	jaugeAmour.value = amour
	if amour < paliersAmour[palierAmour]:
		set_palier_amour(-1)
	elif amour > paliersAmour[palierAmour+1]:
		set_palier_amour(1)

func set_palier_amour(i):
	palierAmour += i
	#print(palierAmour)
	
func frappe():
	gm.frappe()

### réactions ####	
func content(i):
	if anim.current_animation != "arrive" && anim.current_animation !="part":
		anim.play("content")
	set_amour(i)
	tempsDepart += tempsAjouteSiContent
	jaugeDepart.max_value = tempsDepart
		
func pas_content(i):
	if anim.current_animation != "arrive" && anim.current_animation !="part":
		anim.play("pas content")
	set_amour(i)
	tempsDepart -= tempsRetireSiPasContent
	jaugeDepart.max_value = tempsDepart
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
		
		

