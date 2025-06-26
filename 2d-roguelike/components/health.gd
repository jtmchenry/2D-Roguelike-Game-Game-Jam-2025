extends Node
class_name Health

@export var max_health: int = 100
@export var health: int = 100:
	set(value):
		health = clamp(value, 0, max_health)

signal health_changed(current: int, max: int)
signal died

func hit(amount: int):
	health -= amount
	emit_signal("health_changed", health, max_health)
	if health == 0:
		emit_signal("died")

func heal(amount: int):
	health += amount
	emit_signal("health_changed", health, max_health)
