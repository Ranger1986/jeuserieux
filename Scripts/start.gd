extends Node2D
var store_item: Array

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
	store_item = Item.load_items_from_json("res://items.json")
	var scene = preload("res://Scene/item.tscn")
	var store: VBoxContainer = find_child("VBoxContainer")
	for item: Item in store_item:
		var instance = scene.instantiate()
		store.add_child(instance)
		instance.name="item"+str(item.id)
		instance.give_parameters(item)
		instance.owner=self
