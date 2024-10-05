extends Node2D

var budget_player: float
var budget_player_label: Label
var bonheur_label: Label

func load_json(path: String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Array:
			return parsedResult
		else:
			print("Error reading file")
	else:
		print("File doesn't exist!")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	budget_player_label = find_child("Budget_player")
	bonheur_label = find_child("Bonheur")
	budget_player = 10000.0
	var store_item: Array = Item.load_items_from_json("res://items.json")
	var scene = preload("res://Scene/item.tscn")
	var store: VBoxContainer = find_child("VBoxContainer")
	for item: Item in store_item:
		var instance = scene.instantiate()
		store.add_child(instance)
		instance.name="item"+str(item.id)
		instance.give_parameters(item)
		instance.owner=self
		instance.connect("budget_modified_signal", Callable(self, "_on_budget_modified"))
		instance.connect("budget_foyer_modified_signal", Callable(self, "_on_modify_budget_foyer"))
		instance.connect("refresh_display_foyer_signal", Callable(self, "_on_refresh_display_foyer"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	budget_player_label.text = "Budget: " + str(budget_player)
	bonheur_label.text = "Bonheur: " + str(Foyer.get_bonheur_moyen()) + "%"
	pass

# slot (s'appelle lors de la réception du signal)
func _on_budget_modified(amount: float) -> void:
	modify_budget(amount)

func modify_budget(amount: float) -> void:
	budget_player += amount

func _on_modify_budget_foyer(amount: float) -> void:
	modify_budget_foyer(amount)
	
func modify_budget_foyer(amount: float) -> void:
	var target = Foyer.get_foyer_cible()
	target.add_money(amount)

func _on_refresh_display_foyer() -> void:
	var cible = Foyer.get_foyer_cible()
	cible.display_info()
