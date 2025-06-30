extends Control

func _on_play_again_pressed() -> void:
	reset()
	Game.start()
	
func reset():
	Game.current_level = 1
	Player1.reset_player_stats()


func _on_title_screen_pressed() -> void:
	reset()
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_quit_pressed() -> void:
	reset()
	get_tree().quit()
