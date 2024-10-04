extends Control


var id: int
var image: TextureRect
var name_desc: Label
var stock_price: Label
var sell_button: Button
var stock_button: Button
var priceStock: float

signal budget_modified_signal(amount: float)
signal budget_foyer_modified_signal(amount: float)
signal refresh_display_foyer_signal()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image = find_child("Image")
	name_desc = find_child("NameDesc")
	stock_price = find_child("StockPrice")
	sell_button = find_child("Sell")
	stock_button = find_child("Stock")
	pass # Replace with function body.

func give_parameters(info: Item) -> void:	
	id = info.id
	var img = Image.new()
	img.load(info.imgPath)
	var itex = ImageTexture.create_from_image(img)

	image.texture = itex	
	name_desc.text = info.nom + ":\n"
	name_desc.text += "Lum: " + str(info.lumProt) + "\t"
	name_desc.text += "Bruit: " + str(info.noiseProt) 
	stock_price.text = str(info.priceStock) + "$\nx" + str(info.stock)
	priceStock = info.priceStock
	
	
	if info.hide:
		hide();
		
func sell():
	emit_signal("budget_modified_signal", priceStock)
	emit_signal("budget_foyer_modified_signal", -priceStock)
	emit_signal("refresh_display_foyer_signal")
	print("sell")
	
func stock():
	emit_signal("budget_modified_signal", -priceStock)
	print("stock")
