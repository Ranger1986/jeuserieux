extends Node2D

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
	var store_item: Array = load_json("res://items.json")
	var scene = preload("res://Scene/item.tscn")
	for item in store_item:
		var instance = scene.instantiate()
		find_child("VBoxContainer").add_child(instance)
		instance.give_parameters(item)
	
	#var data_to_send = ["a", "b", "c"]
	#var json_string = JSON.stringify(data_to_send)
	#var json = JSON.new()
	#var error = json.parse(json_string)
	#if error == OK:
		#var data_received = json.data
		#if typeof(data_received) == TYPE_ARRAY:
			#print(data_received) # Prints array
		#else:
			#print("Unexpected data")
	#else:
		#print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
