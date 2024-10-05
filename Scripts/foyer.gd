class_name Foyer
extends Button

var etage
var numero
static var liste_foyer : Array
var label : Label

var habitant
var bonheur
var confiance
var luminosite
var son
var budget

var items: Array
static var foyer_cible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	habitant = 1 + randi() % 2  # Random between 1 and 3
	bonheur = randi() % 101  # Random between 0 and 100
	confiance = randi() % 21   # Random between 0 and 20
	luminosite = randi() % 101 # Random between 0 and 100
	son = randi() % 101  # Random between 0 and 100
	budget = 100 + randi() % 101
	pressed.connect(self._button_pressed)
	liste_foyer.append(self)

func _button_pressed():
	Foyer.set_cible(self)
	display_info()
	
func display_info():
	label.text = "Appartement: " + name + "\n"
	label.text += "Habitants:\n" + str(habitant) + "\n"
	label.text += "Bonheur:\n" + str(bonheur) + "%\n"
	label.text += "Confiance:\n" + str(confiance) + "%\n"
	label.text += "Luminosité:\n" + str(luminosite) + "%\n"
	label.text += "Sonorité:\n" + str(son) + "%\n"
	label.text += "Budget:\n" + str(budget) + "$\n"

# Fonction pour récupérer la liste des foyers (accessible a tous)
static func get_foyer_cible() -> Foyer:
	return foyer_cible
	
static func set_cible(cible: Foyer) -> void:
	foyer_cible = cible

func add_money(amount: float) -> void:
	budget += amount

static func get_bonheur_moyen()->int:
	var moyenne : int = 0
	for foyer : Foyer in liste_foyer:
		moyenne+=foyer.bonheur
	moyenne/=liste_foyer.size()
	return moyenne
