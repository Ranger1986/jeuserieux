extends Object

class_name Item

# Propriétés de l'item
var id: int
var nom: String
var imgPath: String
var lumProt: int
var noiseProt: int
var priceStock: float
var stock: int
var hide: bool

# Constructeur
func _init(id: int, nom: String, imgPath: String, lumProt: int, noiseProt: int, priceStock: float, stock: int, hide: bool):
	self.id = id
	self.nom = nom
	self.imgPath = imgPath
	self.lumProt = lumProt
	self.noiseProt = noiseProt
	self.priceStock = priceStock
	self.stock = stock
	self.hide = hide

# Fonction pour afficher les informations de l'item
func print_info():
	print("ID: ", id)
	print("Nom: ", nom)
	print("Image Path: ", imgPath)
	print("Luminosité Protection: ", lumProt)
	print("Bruit Protection: ", noiseProt)
	print("Prix du Stock: ", priceStock)
	print("Quantité en stock: ", stock)
	print("Visible: ", !hide)

# Fonction statique pour lire le JSON et créer une liste d'items
static func load_items_from_json(path: String) -> Array:
	var items = []
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var parsed_result = JSON.parse_string(file.get_as_text())
		if parsed_result is Array:
			for item_data in parsed_result:
				# Création d'un objet Item pour chaque entrée du JSON
				var new_item = Item.new(
					item_data.id,
					item_data.nom,
					item_data.imgPath,
					item_data.lumProt,
					item_data.noiseProt,
					item_data.priceStock,
					item_data.stock,
					item_data.hide
				)
				items.append(new_item)
		file.close()
	else:
		print("Failed to open file: ", path)
	return items
