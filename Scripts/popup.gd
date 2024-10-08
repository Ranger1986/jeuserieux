extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func adjust_label_position(popup_label: Label, start_position: Vector2) -> Vector2:
# Obtenir la taille de la fenêtre
	var window_size = DisplayServer.window_get_size()

	# Obtenir la taille du label (minimum requis pour le texte)
	var label_size = popup_label.get_minimum_size()

	# Ajuster la position si nécessaire
	var adjusted_position = start_position

	# Vérifier si le label dépasse à droite
	if adjusted_position.x + label_size.x > window_size.x:
		adjusted_position.x = window_size.x - label_size.x

	# Vérifier si le label dépasse en bas
	if adjusted_position.y + label_size.y > window_size.y:
		adjusted_position.y = window_size.y - label_size.y

	# Vérifier si le label dépasse à gauche (x doit être >= 0)
	if adjusted_position.x < 0:
		adjusted_position.x = 0

	# Vérifier si le label dépasse en haut (y doit être >= 0)
	if adjusted_position.y < 0:
		adjusted_position.y = 0

	return adjusted_position


func show_popup(message: String, start_position: Vector2, color: bool) -> void:
	# Charge la scène du LabelPopup
	var popup_scene = preload("res://Scene/LabelPopup.tscn")
	
	# Instancier un nouveau LabelPopup
	var popup_instance = popup_scene.instantiate()

	# Ajouter le Label à la scène principale
	var main_scene = get_tree().current_scene
	main_scene.add_child(popup_instance)
	
	# Accéder aux éléments du nouveau Label
	var popup_label = popup_instance.get_node("Label_texte") # Si le label dans la scène est nommé "Popup_label"
	var anim_player = popup_instance.get_node("Label_AnimationPlayer")
	
	# Configurer le label : texte et position
	popup_label.text = message
	
	var adjusted_position = adjust_label_position(popup_label, start_position)
	popup_label.position = adjusted_position
	popup_label.position.y -= 30
	
	# Rendre le label visible et démarrer l'animation
	popup_label.visible = true
	if color == true: 
		anim_player.play("popup_fadeout_green")
	else:
		anim_player.play("popup_fadeout_red")
