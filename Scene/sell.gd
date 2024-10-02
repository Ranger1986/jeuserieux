extends Button

var rect: Rect2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rect = Rect2(Vector2(0,0), size)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if not owner.visible:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if rect.has_point(get_local_mouse_position()):
			owner.sell();
