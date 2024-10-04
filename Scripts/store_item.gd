extends Control


var id: int
var image: TextureRect
var name_desc: Label
var stock_price: Label
var sell_button: Button
var stock_button: Button
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
	
	if info.hide:
		hide();
		
func sell():
	print("sell")
	
func stock():
	print("stock")
