extends Node2D
class_name Health

@export var floating_text_scene: PackedScene
@export var max_health: int = 100
@export var health: int = 100:
	set(value):
		health = clamp(value, 0, max_health)

signal health_changed(current: int, max: int)
signal died

func hit(amount: int, color: Color):
	health -= amount
	emit_signal("health_changed", health, max_health)
	_float_text(amount, color)
	if health == 0:
		emit_signal("died")

func heal(amount: int):
	health += amount
	emit_signal("health_changed", health, max_health)
	
func _float_text(damage: int, color: Color):
	var dmg_text = floating_text_scene.instantiate()
	dmg_text.global_position = global_position
	dmg_text.set_text(str(damage), color)
	get_tree().current_scene.add_child(dmg_text)
