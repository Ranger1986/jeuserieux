extends Control

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)

func _on_option_button_item_selected(index: int) -> void:
	match index:
		0: 
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1: 
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2: 
			DisplayServer.window_set_size(Vector2i(1280, 720))
			
	var CurrSize = DisplayServer.window_get_size()
	var ScreenSize = DisplayServer.screen_get_size()
	var NewPos = Vector2i((ScreenSize.x - CurrSize.x) / 2, (ScreenSize.y - CurrSize.y) / 2)
	DisplayServer.window_set_position(NewPos)
	
func _on_option_button_2_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			$VBoxContainer/VBoxContainerVideo/OptionButton.visible = false
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			$VBoxContainer/VBoxContainerVideo/OptionButton.visible = true

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
