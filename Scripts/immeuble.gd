extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var display = owner.find_child("DisplayLabel")
	for window in get_children():
		if window is Button:
			window.label = display
		
