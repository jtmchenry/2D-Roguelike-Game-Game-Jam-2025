extends Node2D

func _on_monster_spawner_all_monsters_killed() -> void:
	Game.level_complete()
