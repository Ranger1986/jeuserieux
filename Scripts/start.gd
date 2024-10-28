extends Node2D

class_name MainScene

var budget_player: int
var budget_player_label: Label
var bonheur_bar: ProgressBar

static var mainScene : PackedScene = PackedScene.new()

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
	bonheur_bar = find_child("Bonheur")
	budget_player = 1500.0
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
	StoreItem.item_cible=null;

func display_foyer():
	var foyer = Foyer.foyer_cible
	find_child("AptLabel").text="Appartement: " + str(foyer.name)
	find_child("BonBar").value = foyer.bonheur
	find_child("LumBar").value = foyer.luminosite
	find_child("SonBar").value = foyer.son
	find_child("BudLabel").text="Budget: " + str(foyer.budget) +"$"
	find_child("ImgHab").texture = foyer.image
func _process(_delta: float) -> void:
	budget_player_label.text = "Budget: " + str(budget_player) + "$"
	bonheur_bar.value=Foyer.get_bonheur_moyen()
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
	if store_item.stockAmount == 0:
		GlobalPopup.show_popup("Stock insuffisant", get_viewport().get_mouse_position(), 0)
		StoreItem.item_cible = null
		return
	var target = Foyer.get_foyer_cible()
	if target != null:
		var instance = preload("res://Scene/marchandage.tscn").instantiate()
		add_child(instance)
		instance.position= (Vector2(1280,720) - instance.get_child(0).size) /2
		instance.connect("sell_end_signal", Callable(self, "_end_sell"))
		instance.set_item(store_item.item)

func _on_refresh_display_foyer() -> void:
	var cible = Foyer.get_foyer_cible()
	cible.display_info()
	
func _end_sell(price:int):
	# DEBUG
	if (StoreItem.item_cible == null):
		print("Item is null, cannot proceed with the sale.")
		return
	# FIN DEBUG
	# Foyer.foyer_cible.bonheur = min(max(Foyer.foyer_cible.bonheur + (item.priceStock-price )/item.priceStock * 100,0),100)
	Foyer.foyer_cible.luminosite = max(Foyer.foyer_cible.luminosite - StoreItem.item_cible.item.lumProt, 0) # Update des lumières
	Foyer.foyer_cible.luminosite = min(Foyer.foyer_cible.luminosite - StoreItem.item_cible.item.lumProt, 100) # Update des lumières
	
	Foyer.foyer_cible.son = max(Foyer.foyer_cible.son - StoreItem.item_cible.item.noiseProt, 0) # Update des sons
	Foyer.foyer_cible.son = min(Foyer.foyer_cible.son - StoreItem.item_cible.item.noiseProt, 100) # Update des sons
	
	print("Avant : " + str(Foyer.foyer_cible.bonheur))
	var bonheur = Foyer.foyer_cible.bonheur + (Foyer.foyer_cible.luminosite + Foyer.foyer_cible.son) / 2 / 10
	print("1 : " + str(bonheur))
	bonheur = (int)(max(bonheur, 0)) 
	print("2 : " + str(bonheur))
	bonheur = (int)(min(bonheur, 100))
	print("3 : " + str(bonheur))
	Foyer.foyer_cible.set_bonheur(bonheur)
	
	print("Après : " + str(Foyer.foyer_cible.bonheur))
	
	
	GlobalPopup.show_popup(str(price)+"$", get_viewport().get_mouse_position(), 1)
	Foyer.foyer_cible.budget -= price
	budget_player+=price
	
	StoreItem.item_cible.stockAmount-=1
	StoreItem.item_cible.display()
	StoreItem.item_cible = null
	
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		for foyer : Foyer in Foyer.liste_foyer:
			foyer.bonheur_timer.stop()
			foyer.budget_timer.stop()
		var root = get_node("/root")
		var nextScene = load("res://Scene/options_mainFrame.tscn")
		nextScene = nextScene.instantiate()
		root.add_child(nextScene)
