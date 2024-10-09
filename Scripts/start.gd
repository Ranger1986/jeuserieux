extends Node2D

var budget_player: int
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
	
		

func display_foyer():
	var foyer = Foyer.foyer_cible
	find_child("AptLabel").text="Appartement: " + str(foyer.name)
	find_child("HabLabel").text="Habitant: " + str(foyer.habitant)
	find_child("BonBar").value = foyer.bonheur
	find_child("LumBar").value = foyer.luminosite
	find_child("SonBar").value = foyer.son
	find_child("BudLabel").text="Budget: " + str(foyer.budget) +"$"
func _process(_delta: float) -> void:
	budget_player_label.text = "Budget: " + str(budget_player)
	bonheur_label.text = "Bonheur: " + str(Foyer.get_bonheur_moyen()) + "%"
	if Input.is_key_pressed(KEY_D):
		find_children("Control")[0].print_tree()
	if Foyer.foyer_cible != null:
		display_foyer()

## slot (s'appelle lors de la réception du signal), modifie le budget du joueur
func _on_stock(store_item: StoreItem) -> void:
	if budget_player - store_item.item.priceStock >= 0 :
		GlobalPopup.show_popup(str(store_item.item.priceStock)+"$", get_viewport().get_mouse_position(), 0)
		budget_player -= store_item.item.priceStock
		store_item.stockAmount+=1
		store_item.display()
	else :
		GlobalPopup.show_popup("Budget insuffisant", get_viewport().get_mouse_position(), 0)
		print("Budget insufisant")
func _on_sell(store_item: StoreItem) -> void:
	var target = Foyer.get_foyer_cible()
	if target != null:
		var instance = preload("res://Scene/marchandage.tscn").instantiate()
		add_child(instance)
		instance.position= (Vector2(1280,720) - instance.get_child(0).size) /2
		instance.set_item(store_item.item)
		instance.connect("sell_end_signal", Callable(self, "_end_sell"))

func _on_refresh_display_foyer() -> void:
	var cible = Foyer.get_foyer_cible()
	cible.display_info()
	
func _end_sell(item: Item, price:int):
	Foyer.foyer_cible.bonheur = min(max(Foyer.foyer_cible.bonheur + (item.priceStock-price )/item.priceStock * 100,0),100)
	Foyer.foyer_cible.budget -= price
	Foyer.foyer_cible.display_info()
	budget_player+=price
	
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_tree().change_scene_to_file("res://Scene/options_mainFrame.tscn")
