extends ProgressBar

var stBox : StyleBoxFlat 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	theme = Theme.new()
	theme.add_type("ProgressBar")
	theme.set_stylebox("fill","ProgressBar",StyleBoxFlat.new())
	stBox = theme.get_stylebox("fill","ProgressBar")
	stBox.draw_center=true
	stBox.border_width_bottom=0
	stBox.border_width_top=0
	stBox.border_width_left=0
	stBox.border_width_right=0
	stBox.corner_radius_bottom_left=5
	stBox.corner_radius_bottom_right=5
	stBox.corner_radius_top_left=5
	stBox.corner_radius_top_right=5
	_value_changed(value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _value_changed(new_value: float) -> void:
	if (new_value<30):
		stBox.bg_color = Color(255,0,0)
		theme.set_stylebox("fill", "ProgressBar", stBox)
	elif (new_value<60):
		stBox.bg_color = Color(255,255,0)
		theme.set_stylebox("fill", "ProgressBar", stBox)
	elif (new_value<80):
		stBox.bg_color = Color(128,192,0)
		theme.set_stylebox("fill", "ProgressBar", stBox)
	else:
		stBox.bg_color = Color(0,255,0)
		theme.set_stylebox("fill", "ProgressBar", stBox)
