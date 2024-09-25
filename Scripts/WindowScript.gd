extends Sprite2D

var desc
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	desc = owner.find_child("Description")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			print("window")
			print(owner.habitant)
	elif event is InputEventMouseMotion:
		if get_rect().has_point(to_local(event.position)):
			desc.show()
		else:
			desc.hide()
