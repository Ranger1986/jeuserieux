extends Node2D

func _on_button_3_pressed() -> void:
	get_tree().quit()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/options.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main_frame.tscn")