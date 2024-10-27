class_name StoreItem
extends Control

var item: Item

var stockAmount: int

var image: TextureRect
var icone_power_light: TextureRect
var icone_power_sound: TextureRect

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
	icone_power_light = find_child("power_light")
	icone_power_sound = find_child("power_sound")
	
	if(item.lumProt <= -12.5):
		icone_power_light.texture = load("res://Assets/up2.png")
	else: if(item.lumProt < 0):
		icone_power_light.texture = load("res://Assets/up1.png")
	else: if(item.lumProt == 0):
		icone_power_light.texture = load("res://Assets/neutre.png")
	else: if(item.lumProt <= 12.5):
		icone_power_light.texture = load("res://Assets/down1.png")
	else:	
		icone_power_light.texture = load("res://Assets/down2.png")
		
	if(item.noiseProt <= -12.5):
		icone_power_sound.texture = load("res://Assets/up2.png")
	else: if(item.noiseProt < 0):
		icone_power_sound.texture = load("res://Assets/up1.png")
	else: if(item.noiseProt == 0):
		icone_power_sound.texture = load("res://Assets/neutre.png")
	else: if(item.noiseProt <= 12.5):
		icone_power_sound.texture = load("res://Assets/down1.png")
	else:	
		icone_power_sound.texture = load("res://Assets/down2.png")
		
	if item.hide:
		hide();
	display()
		
func display():
	name_desc.text = item.nom + ":\n"
	stock_price.text = str(item.priceStock) + "$\nx" + str(stockAmount)
func sell():
	emit_signal("sell_signal", self)
	
func stock():
	emit_signal("stock_signal", self)
