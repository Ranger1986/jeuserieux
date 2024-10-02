extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var display = owner.find_child("DisplayLabel")
	var scene = preload("res://Scene/window.tscn")
	var size = find_child("Immeuble").get_rect().size
	#print(find_child("Immeuble").get_rect().position)
	var positionInstance = Vector2(0,0)
	var margin = 10
	for i in range(4):
		var instance = scene.instantiate()
		add_child(instance)
		instance.name = "w" + str(3-i)+ str(0)
		positionInstance.y= -size.y/4 + size.y/6*i + instance.size.y/2 +margin
		positionInstance.x= -size.x/2 + instance.size.x/2 + margin
		instance.position=positionInstance
		instance.label = display
		
		var instance2 = scene.instantiate()
		positionInstance.x= size.x/2 - instance.size.x/2 - margin
		instance2.position=positionInstance
		add_child(instance2)
		instance2.name = "w" + str(3-i)+ str(0)
		instance2.label = display
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
