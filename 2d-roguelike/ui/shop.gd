extends Control

@onready var grid_container = $GridContainer  # Reference to GridContainer node
@onready var gold_label = $GoldLabel  # Reference to Label for player gold
var shop_item_scene = preload("res://ui/shop_item.tscn")

var shop_items = [
	{"id": 1, "name": "Damage %", "price": 10 },
	{"id": 2, "name": "Attack %", "price": 25 },
	{"id": 3, "name": "Crit Damage", "price": 50 },
	{"id": 4, "name": "Crit Chance", "price": 25 },
	{"id": 5, "name": "Range", "price": 20 }
]
var player_gold = 100

func _ready():
	update_gold_display()
	populate_shop()

func update_gold_display():
	gold_label.text = "%d" % player_gold

func populate_shop():
	# Clear existing items
	for child in grid_container.get_children():
		child.queue_free()
	
	# Create an item UI for each shop item
	for item in shop_items:
		var item_instance = shop_item_scene.instantiate()
		grid_container.add_child(item_instance)
		item_instance.set_item_data(item)
		
		var buy_button = item_instance.get_node("VBoxContainer/VBoxContainer/BuyButton")
		buy_button.connect("pressed", _on_buy_button_pressed.bind(item))

func _on_buy_button_pressed(item):
	if player_gold >= item.price:
		player_gold -= item.price
		update_gold_display()
		populate_shop()  # Refresh to update disabled buttons
		print("Bought %s for %d gold!" % [item.name, item.price])
	else:
		print("Not enough gold!")

func _on_finish_pressed() -> void:
	Game.upgrade_complete()
