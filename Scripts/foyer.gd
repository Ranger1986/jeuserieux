class_name Foyer
extends Button

static var liste_foyer : Array
const BESOIN_CEIL = 80 
const BESOIN_FLOOR = 60 
var etage
var numero
var label : Label

var bonheur : float
var confiance 
var luminosite : float
var son : float
var budget
var image : ImageTexture

var items: Array
static var foyer_cible : Foyer

# décrementation du bonheur en fonction du temps (simulation du bonheur global de l'immeuble comme dans des jeux de gestion)s
var decrbonheur: float = 0.5 # en seconde
var valeurDecrBonheur = 0.00005 # en %
var bonheur_timer: Timer

var incrbudget: float = 15.
var incrArgentHabitant = 100
var budget_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bonheur_timer = Timer.new()
	bonheur_timer.wait_time = decrbonheur
	bonheur_timer.one_shot = false 
	bonheur_timer.connect("timeout", Callable(self, "_on_bonheur_timer_timeout"))
	
	budget_timer = Timer.new()
	budget_timer.wait_time = incrbudget
	budget_timer.one_shot = false 
	budget_timer.connect("timeout", Callable(self, "_on_budget_timer_timeout"))
	
	add_child(bonheur_timer)
	bonheur_timer.start()
	
	add_child(budget_timer)
	budget_timer.start()

	bonheur = 50 
	luminosite = 50 + randi() % 41 
	son = 50 + randi() % 41
	budget = 100 + randi() % 150
	pressed.connect(self._button_pressed)
	liste_foyer.append(self)
	var imgString = get_meta("Img")
	if (imgString != null):
		var img : Image = Image.new()
		img.load(imgString)
		image= ImageTexture.create_from_image(img)

func _on_bonheur_timer_timeout() -> void:
	bonheur -= bonheur * valeurDecrBonheur
	bonheur = max(bonheur, 0)
	
func _on_budget_timer_timeout() -> void:
	budget = budget + randi_range(0, 15)	

func _process(delta: float) -> void:

	if(bonheur < 50):
		get_children()[0].show()
		var anim_player = get_node("animation_texte_bulle")
		anim_player.play("idle")
	else:
		get_children()[0].hide()
	
	if(get_bonheur_moyen() >= 95):
		get_tree().change_scene_to_file("res://Scene/EndGame.tscn")

		
func _button_pressed():
	Foyer.set_cible(self)

# Fonction pour récupérer la liste des foyers (accessible a tous)
static func get_foyer_cible() -> Foyer:
	return foyer_cible
	
static func set_cible(cible: Foyer) -> void:
	foyer_cible = cible

func add_money(amount: float) -> void:
	budget += amount

static func get_bonheur_moyen() -> int:
	var moyenne : float = 0
	var valid_foyer_count = 0

	for foyer in liste_foyer:
		if is_instance_valid(foyer):
			moyenne += foyer.bonheur
			valid_foyer_count += 1
			
	if valid_foyer_count > 0:
		moyenne /= valid_foyer_count 
	else:
		moyenne = 0
	return int(moyenne)

func set_bonheur(m_bonheur : int):
	bonheur=m_bonheur
