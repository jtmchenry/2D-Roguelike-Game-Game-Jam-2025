extends ProgressBar
class_name PlayerHealthBar

@export var max_health = 100
@export var current_health = 100:
	set(value):
		current_health = clamp(value, 0, max_health)

func _process(delta) -> void:
	value = current_health * 100 / max_health
	return 

func damage(value) -> void:
	current_health -= value
	
func heal(value) -> void:
	current_health += value
