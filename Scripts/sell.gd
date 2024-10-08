extends Button

var rect: Rect2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rect = Rect2(Vector2(0,0), size)
	pass

func _input(event: InputEvent) -> void:
	if not owner.visible:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if rect.has_point(get_local_mouse_position()):
			if Foyer.get_foyer_cible() != null:
				owner.sell();
			else:
				GlobalPopup.show_popup("Aucune cible", get_viewport().get_mouse_position(), 0)
				print("Aucune cible")
