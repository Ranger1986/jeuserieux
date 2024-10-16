class_name StoreItem
extends Control

var item: Item

var stockAmount: int

var image: TextureRect

var name_desc: Label
var stock_price: Label

var sell_button: Button
var stock_button: Button
signal sell_signal(item: StoreItem)
signal stock_signal(item: StoreItem)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image = find_child("Image")
	name_desc = find_child("NameDesc")
	stock_price = find_child("StockPrice")
	sell_button = find_child("Sell")
	stock_button = find_child("Stock")
	pass # Replace with function body.

func give_parameters(info: Item) -> void:
	item=info
	var img = Image.new()
	img.load(item.imgPath)
	var itex = ImageTexture.create_from_image(img)
	image.texture = itex	
	stockAmount=0
	if item.hide:
		hide();
	display()
		
func display():
	name_desc.text = item.nom + ":\n"
	name_desc.text += "Lum: " + str(item.lumProt) + "     "
	name_desc.text += "Bruit: " + str(item.noiseProt) 
	stock_price.text = str(item.priceStock) + "$\nx" + str(stockAmount)
func sell():
	emit_signal("sell_signal", self)
	
func stock():
	emit_signal("stock_signal", self)
