extends Control

@onready var money_src: Money = $"../../Player/Money"
@onready var label: Label = $HBoxContainer/Label

func _ready() -> void:
	money_src.connect("money_changed", _handle_money_change)

func _process(delta) -> void:
	label.text = "$%s" % Player1.money
	return 
	
func _handle_money_change(amount: int):
	Player1.money = amount
