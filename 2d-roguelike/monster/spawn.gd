extends Node2D

@export var monster_scene: PackedScene

func _on_timer_timeout() -> void:
	var monster = monster_scene.instantiate()
	monster.global_position = global_position
	get_parent().add_child(monster)
	queue_free()
