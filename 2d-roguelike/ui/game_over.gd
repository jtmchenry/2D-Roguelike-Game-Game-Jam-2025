extends CanvasLayer

func _on_play_again_pressed() -> void:
	reset()
	Game.start()

func reset():
	Game.current_level = 1
	Player1.reset_player_stats()
