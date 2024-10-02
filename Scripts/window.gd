extends Sprite2D

var foyer : Foyer  # Type-safe reference to Foyer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make sure owner is not null
	if owner != null:
		owner.size = get_rect().size * scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			owner.display_info()
