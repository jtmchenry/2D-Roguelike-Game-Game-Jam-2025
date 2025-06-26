extends ProgressBar
class_name PlayerHealthBar

var max_health: int = 0
var current_health: int = 0
@onready var health_src: Health = $"../../Player/Health"
@onready var label: Label = $Label

func _ready() -> void:
	current_health = health_src.health
	max_health = health_src.max_health
	health_src.connect("health_changed", _handle_health_change)

func _process(delta) -> void:
	label.text = "%s / %s" % [current_health, max_health]
	if max_health == 0:
		return
	value = current_health * 100 / max_health
	return 
	
func _handle_health_change(current: int, max: int):
	current_health = current
	max_health = max
