extends Node

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func adjust_label_position(popup_label: Label, start_position: Vector2) -> Vector2:
	var window_size = DisplayServer.window_get_size()
	
	var label_size = popup_label.get_minimum_size()

	var adjusted_position = start_position

	if adjusted_position.x + label_size.x > window_size.x:
		adjusted_position.x = window_size.x - label_size.x

	if adjusted_position.y + label_size.y > window_size.y:
		adjusted_position.y = window_size.y - label_size.y

	if adjusted_position.x < 0:
		adjusted_position.x = 0

	if adjusted_position.y < 0:
		adjusted_position.y = 0

	return adjusted_position


func show_popup(message: String, start_position: Vector2, color: bool) -> void:

	var popup_scene = preload("res://Scene/LabelPopup.tscn")

	var popup_instance = popup_scene.instantiate()

	var main_scene = get_tree().current_scene
	main_scene.add_child(popup_instance)
	

	var popup_label = popup_instance.get_node("Label_texte")
	var anim_player = popup_instance.get_node("Label_AnimationPlayer")
	
	popup_label.text = message
	
	var adjusted_position = adjust_label_position(popup_label, start_position)
	popup_label.position = adjusted_position
	popup_label.position.y -= 30
	
	popup_label.visible = true
	if color == true: 
		anim_player.play("popup_fadeout_green")
	else:
		anim_player.play("popup_fadeout_red")
