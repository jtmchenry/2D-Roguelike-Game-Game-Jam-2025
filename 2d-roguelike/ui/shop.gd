extends Control

@onready var grid_container = $GridContainer  # Reference to GridContainer node
@onready var gold_label = $GoldLabel  # Reference to Label for player gold
var shop_item_scene = preload("res://ui/shop_item.tscn")

var shop_items = [
	{"id": 1, "name": "2% Damage", "value": 2, "price": 2, "icon": "res://icons/shop_icon/Flexing_Muscles Emoji.png", "hover": "Increases your base damage by 2%."},
	{"id": 2, "name": "2% Attack Speed", "value": 2, "price": 4, "icon": "res://icons/shop_icon/Grimacing.png", "hover": "Increases your attack speed by 2%."},
	{"id": 3, "name": "5% Critical Damage", "value": 5, "price": 4, "icon": "res://icons/shop_icon/Sunglasses.png", "hover": "Increases your critical damage by 5%."},
	{"id": 4, "name": "3% Critical Chance", "value": 3, "price": 3, "icon": "res://icons/shop_icon/Eyes_Emoji.png", "hover": "Increases your chance to land a critical hit by 3%."},
	{"id": 5, "name": "10 Range", "value": 10, "price": 1, "icon": "res://icons/shop_icon/Hugging.png", "hover": "Increases your range to find an enemy by 10."},
	{"id": 6, "name": "Gun", "value": 50, "price": 50, "icon": "res://icons/shop_icon/gun_icon.png", "hover": "Gun Stats are: Base Damage: 10, Critical Chance: 5%, Critical Damage: 50%, and Weapon Range: 100"}
]

func _ready():
	update_gold_display()
	populate_shop()
	AudioManager.play_music("res://audio/MirthmellowMarket.wav")

func update_gold_display():
	gold_label.text = "%d" % Player1.money

func populate_shop():
	# Clear existing items
	for child in grid_container.get_children():
		child.queue_free()
	
	$VBoxContainer/Damage.text = str(Player1.damage_percentage_boost)
	$VBoxContainer/AttackSpeed.text = str(Player1.attack_speed_boost)
	$VBoxContainer/Range.text = str(Player1.weapon_range)
	$VBoxContainer/CritDamage.text = str(Player1.critical_damage_boost)
	$VBoxContainer/CritChance.text = str(Player1.critical_chance_boost)
	
	# Create an item UI for each shop item
	for item in shop_items:
		if item.name == "Gun": 
			if Player1.equipped == [true, true, true, true]:
				print("You have too many guns")
				continue
		if item.name == "3% Crit Chance":
			if Player1.critical_chance_boost >= 96:
				print("You have max Critical Chance")
				continue
		var item_instance = shop_item_scene.instantiate()
		grid_container.add_child(item_instance)
		item_instance.set_item_data(item)
		var buy_button = item_instance.get_node("VBoxContainer/VBoxContainer/BuyButton")
		buy_button.connect("pressed", _on_buy_button_pressed.bind(item))

func _on_buy_button_pressed(item):
	if Player1.money >= Game.game_shop_item_price_scaling(item.price):
		Player1.money -= Game.game_shop_item_price_scaling(item.price)
		Player1.update_player_stats_on_upgrade(item.id, item.value)
		update_gold_display()
		populate_shop()
		print("Bought %s for %d gold!" % [item.name, Game.game_shop_item_price_scaling(item.price)])
	else:
		print("Not enough gold!")

func _on_finish_pressed() -> void:
	Game.start()
