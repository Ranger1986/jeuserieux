extends Node2D

var budget_player: float
var budget_player_label: Label

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
	budget_player = 10000.0
	var store_item: Array = Item.load_items_from_json("res://items.json")
	var scene = preload("res://Scene/item.tscn")
	for item: Item in store_item:
		var instance = scene.instantiate()
		find_child("VBoxContainer").add_child(instance)
		instance.give_parameters(item)
		instance.owner=self
		instance.connect("budget_modified_signal", Callable(self, "_on_budget_modified"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	budget_player_label = find_child("Budget_player")
	budget_player_label.text = "Budget : " + str(budget_player)
	pass

func _on_budget_modified(amount: float) -> void:
	modify_budget(amount)

func modify_budget(amount: float) -> void:
	budget_player += amount
