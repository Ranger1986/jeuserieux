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
	var ColDepart: Color
	var ColFin: Color
	var t: float

	if new_value < 30:
		ColDepart = Color(1, 0, 0)
		ColFin = Color(1, 1, 0)  
		t = new_value / 30.0
	elif new_value < 60:
		ColDepart = Color(1, 1, 0) 
		ColFin = Color(0.5, 0.75, 0) 
		t = (new_value - 30.0) / 30.0
	elif new_value < 80:
		ColDepart = Color(0.5, 0.75, 0)
		ColFin = Color(0, 1, 0)   
		t = (new_value - 60.0) / 20.0
	else:
		ColDepart = Color(0, 1, 0)
		ColFin = Color(0, 1, 0)
		t = 0.0
		
	var inter = ColDepart.lerp(ColFin, t)
	
	stBox.bg_color = inter
	theme.set_stylebox("fill", "ProgressBar", stBox)
