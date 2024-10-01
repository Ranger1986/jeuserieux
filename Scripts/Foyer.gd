class_name Foyer
extends Node2D

var size
var etage
var numero

var label : Label

var habitant
var happiness
var confiance
var luminosite
var son
var budget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	habitant = 1 + randi() % 2  # Random between 1 and 3
	happiness = randi() % 101  # Random between 0 and 100
	confiance = randi() % 21   # Random between 0 and 20
	luminosite = randi() % 101 # Random between 0 and 100
	son = randi() % 101  # Random between 0 and 100
	budget = 100 +randi() % 101

	pass # Replace with function body.

func display_info() -> void:
	label.text = "Appartement: " + name + "\n"
	label.text += "Habitants:\n" + str(habitant) + "\n"
	label.text += "Bonheur:\n" + str(happiness) + "%\n"
	label.text += "Confiance:\n" + str(confiance) + "%\n"
	label.text += "Luminosité:\n" + str(luminosite) + "%\n"
	label.text += "Sonorité:\n" + str(son) + "%\n"
	label.text += "Budget:\n" + str(budget) + "$\n"
