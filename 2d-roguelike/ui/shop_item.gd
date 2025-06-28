extends PanelContainer

@onready var icon = $VBoxContainer/Icon
@onready var item_name = $VBoxContainer/ItemName
@onready var price = $VBoxContainer/VBoxContainer/Price
@onready var buy_button = $VBoxContainer/VBoxContainer/BuyButton

func set_item_data(item):
	item_name.text = item.name
	price.text = "%d" % item.price
	buy_button.disabled = item.price > Player1.money
