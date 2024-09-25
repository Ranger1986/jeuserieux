extends Node2D

var habitant
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	habitant = randi_range(0,3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
