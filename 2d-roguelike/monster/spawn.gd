extends Node2D

@export var monster_scene: PackedScene

@onready var health: int

func _on_timer_timeout() -> void:
	var monster = monster_scene.instantiate()
	monster.global_position = global_position
	get_parent().add_child(monster)
	monster.set_health_value(health)
	queue_free()
