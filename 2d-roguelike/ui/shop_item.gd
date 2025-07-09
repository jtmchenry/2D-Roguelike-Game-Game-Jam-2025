extends PanelContainer

@onready var icon = $VBoxContainer/MarginContainer/Icon
@onready var item_name = $VBoxContainer/ItemName
@onready var price = $VBoxContainer/VBoxContainer/Price
@onready var buy_button = $VBoxContainer/VBoxContainer/BuyButton

func set_item_data(item):
	item_name.text = item.name
	price.text = "%d" % Game.game_shop_item_price_scaling(item.price)
	buy_button.disabled = Game.game_shop_item_price_scaling(item.price) > Player1.money
	icon.texture = load(item.icon)
	icon.size = Vector2(16, 16)
	icon.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
