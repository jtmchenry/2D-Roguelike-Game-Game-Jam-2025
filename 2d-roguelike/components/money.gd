extends Node
class_name Money

@export var amount: int = 0

signal money_changed(current: int)

func earn(value: int) -> void:
	amount += value
	Player1.money += value
	emit_signal("money_changed", amount)
	

func spend(value: int) -> void:
	amount -= value
	Player1.money -= value
	emit_signal("money_changed", amount)
