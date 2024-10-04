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
func _init(p_id: int, p_nom: String, p_imgPath: String, p_lumProt: int, p_noiseProt: int, p_priceStock: float, p_stock: int, p_hide: bool):
	id = p_id
	nom = p_nom
	imgPath = p_imgPath
	lumProt = p_lumProt
	noiseProt = p_noiseProt
	priceStock = p_priceStock
	stock = p_stock
	hide = p_hide

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
