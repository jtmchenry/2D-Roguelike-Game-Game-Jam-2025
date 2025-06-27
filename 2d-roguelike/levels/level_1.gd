extends Node2D

@onready var game_over_modal = $GameOver
var time_limit = 5.0  # seconds
var elapsed = 0.0
var done = false

func _ready() -> void:
	$AudioPlayer.play()

func _on_monster_spawner_all_monsters_killed() -> void:
	await get_tree().create_timer(2.0).timeout
	Game.level_complete()

func _on_player_player_died() -> void:
	game_over_modal.show()
	Game.game_over()
