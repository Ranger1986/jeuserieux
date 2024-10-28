class_name Foyer
extends Button

static var liste_foyer : Array
const BESOIN_CEIL = 80 
const BESOIN_FLOOR = 60 
var etage
var numero
var label : Label

var bonheur : float
var confiance 
var luminosite : float
var son : float
var budget
var image : ImageTexture
var event_message = ""

var items: Array
static var foyer_cible : Foyer

# décrementation du bonheur en fonction du temps (simulation du bonheur global de l'immeuble comme dans des jeux de gestion)s
var decrbonheur: float = 0.5 # en seconde
var valeurDecrBonheur = 0.00005 # en %
var bonheur_timer: Timer

var incrbudget: float = 30.
var incrArgentHabitant = 100
var budget_timer: Timer

var alea_timer: Timer

func _ready() -> void:
	bonheur_timer = Timer.new()
	bonheur_timer.wait_time = decrbonheur
	bonheur_timer.one_shot = false 
	bonheur_timer.connect("timeout", Callable(self, "_on_bonheur_timer_timeout"))
	
	budget_timer = Timer.new()
	budget_timer.wait_time = incrbudget
	budget_timer.one_shot = false 
	budget_timer.connect("timeout", Callable(self, "_on_budget_timer_timeout"))
	
	alea_timer = Timer.new()
	# en même temps que lorsque les habitants reçoivent l'argent
	alea_timer.wait_time = incrbudget
	alea_timer.one_shot = false 
	alea_timer.connect("timeout", Callable(self, "_on_alea_timer_timeout"))
	
	add_child(bonheur_timer)
	bonheur_timer.start()
	
	add_child(budget_timer)
	budget_timer.start()
	
	add_child(alea_timer)
	alea_timer.start()
	
	bonheur = 50 
	luminosite = 50 + randi() % 41 
	son = 50 + randi() % 41
	budget = 100 + randi() % 150
	pressed.connect(self._button_pressed)
	liste_foyer.append(self)
	var imgString = get_meta("Img")
	if (imgString != null):
		var img : Image = Image.new()
		img.load(imgString)
		image= ImageTexture.create_from_image(img)

func _on_bonheur_timer_timeout() -> void:
	bonheur -= bonheur * valeurDecrBonheur
	bonheur = max(bonheur, 0)
	
func _on_budget_timer_timeout() -> void:
	budget = budget + randi_range(0, 15)	
	
func _on_alea_timer_timeout() -> void:
	var event_type = randi() % 3  # 0 pour lumière, 1 pour bruit, 2 pour les deux
	var incr = randf_range(0, 10) 
	var event_label : Label

	match event_type:
		0:
			# MAJ luminosité - sources de lumière variées
			luminosite = clamp(luminosite + incr, 0, 100)
			var light_events = [
				"L'ampadaire clignote  \ndans la rue, augmentant légèrement \nla luminosité",
				"Les voisins allument \nun projecteur, baignant la pièce \ndans une lumière vive",
				"Une enseigne néon à \nl'extérieur brille intensément, \néclairant votre appartement"
			]
			event_message = light_events[randi() % light_events.size()] + " \n" + "Conséquences : +" + String("%.2f" % incr) + " de luminosité"
			
		1:
			# MAJ bruit - sources de bruit diverses
			son = clamp(son + incr, 0, 100)
			var noise_events = [
				"Les travaux bruyants \ndans la rue perturbent le silence",
				"Un camion poubelle \npasse en faisant un bruit \nassourdissant",
				"Les voisins organisent \nune fête bruyante dans leur \nappartement"
			]
			event_message = noise_events[randi() % noise_events.size()] + " \n" + "Conséquences : +" + String("%.2f" % incr) + " de bruit"

		2:
			# MAJ luminosité et bruit - événements combinés
			luminosite = clamp(luminosite + incr, 0, 100)
			son = clamp(son + incr, 0, 100)
			var combined_events = [
				"Une voiture passe avec \nles phares allumés \net la musique à fond",
				"Un éclair illumine \nbrièvement le ciel, suivi d'un \ngrondement de tonnerre",
				"Les ouvriers installent \nde nouvelles lampes en faisant \nbeaucoup de bruit"
			]
			event_message = combined_events[randi() % combined_events.size()] + " \n" + "Conséquences : +" + String("%.2f" % incr) + " de lumière et \nde bruit"
	
	bonheur -= (luminosite + son) / 5 / 10
	
func _process(delta: float) -> void:

	if(bonheur < 50):
		get_children()[0].show()
		var anim_player = get_node("animation_texte_bulle")
		anim_player.play("idle")
	else:
		get_children()[0].hide()
	
	if(get_bonheur_moyen() >= 95):
		get_tree().change_scene_to_file("res://Scene/EndGame.tscn")

		
func _button_pressed():
	Foyer.set_cible(self)

# Fonction pour récupérer la liste des foyers (accessible a tous)
static func get_foyer_cible() -> Foyer:
	return foyer_cible
	
static func set_cible(cible: Foyer) -> void:
	foyer_cible = cible

func add_money(amount: float) -> void:
	budget += amount

static func get_bonheur_moyen() -> int:
	var moyenne : float = 0
	var valid_foyer_count = 0

	for foyer in liste_foyer:
		if is_instance_valid(foyer):
			moyenne += foyer.bonheur
			valid_foyer_count += 1
			
	if valid_foyer_count > 0:
		moyenne /= valid_foyer_count 
	else:
		moyenne = 0
	return int(moyenne)

func set_bonheur(m_bonheur : int):
	bonheur=m_bonheur
