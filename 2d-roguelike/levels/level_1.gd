extends Node2D

@onready var game_over_modal = $GameOver

func _ready() -> void:
	$AudioPlayer.play()

func _on_monster_spawner_all_monsters_killed() -> void:
	Game.level_complete()


func _on_player_player_died() -> void:
	game_over_modal.show()
	Game.game_over()
