class_name Foyer
extends Button

static var liste_foyer : Array
const BESOIN_CEIL = 80 
const BESOIN_FLOOR = 60 
var etage
var numero
var label : Label

var habitant
var bonheur : float
var confiance 
var luminosite : float
var son : float
var budget

var items: Array
static var foyer_cible : Foyer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	habitant = 1 + randi() % 2  # Random between 1 and 3
	bonheur = 50 # randi() % 101  # Random between 0 and 100
	luminosite = 50 + randi() % 41 # Random between 0 and 100
	son = 50 + randi() % 41  # Random between 0 and 100
	budget = 100 + randi() % 101
	pressed.connect(self._button_pressed)
	liste_foyer.append(self)
func _process(delta: float) -> void:
	var besoin_facteur = 0
	if luminosite<BESOIN_FLOOR:
		besoin_facteur-=BESOIN_FLOOR-luminosite
	if luminosite>BESOIN_CEIL:
		besoin_facteur+=luminosite-BESOIN_CEIL
	if son<BESOIN_FLOOR:
		besoin_facteur-=BESOIN_FLOOR-luminosite
	if son>BESOIN_CEIL:
		besoin_facteur+=luminosite-BESOIN_CEIL
	bonheur+=bonheur*besoin_facteur/100*delta
	bonheur = max(min(bonheur,100),0)
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
