extends Control

var item : Item
var priceControl : SpinBox
signal sell_end_signal(prix: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	priceControl = find_child("SpinBox")
	find_child("SellButton").pressed.connect(self.end_sell)
	find_child("BackButton").pressed.connect(self.annulation)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_item(p_item: Item)->void:
	item=p_item
	priceControl.value=item.priceStock

func end_sell()->void:
	if (Foyer.foyer_cible.budget>priceControl.value) :
		emit_signal("sell_end_signal", priceControl.value)
		self.queue_free()
		return
	GlobalPopup.show_popup("Budget insuffisant", get_viewport().get_mouse_position(), 0)
	
func annulation()->void:
	StoreItem.item_cible = null
	self.queue_free()
