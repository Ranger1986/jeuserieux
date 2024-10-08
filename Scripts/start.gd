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
		instance.connect("sell_signal", Callable(self, "_on_sell"))
		instance.connect("stock_signal", Callable(self, "_on_stock"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	budget_player_label.text = "Budget: " + str(budget_player)
	bonheur_label.text = "Bonheur: " + str(Foyer.get_bonheur_moyen()) + "%"
	if Input.is_key_pressed(KEY_D):
		print_tree()

## slot (s'appelle lors de la réception du signal), modifie le budget du joueur
func _on_stock(store_item: StoreItem) -> void:
	if budget_player - store_item.item.priceStock >= 0 :
		budget_player -= store_item.item.priceStock
		store_item.stockAmount+=1
		store_item.display()
	else :
		print("Budget insufisant")
func _on_sell(store_item: StoreItem) -> void:
	var target = Foyer.get_foyer_cible()
	if target != null:
		pass
