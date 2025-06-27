extends CanvasLayer

func _ready() -> void:
	$MainMenuMusic.play()

func _on_start_button_pressed() -> void:
	Game.start()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
