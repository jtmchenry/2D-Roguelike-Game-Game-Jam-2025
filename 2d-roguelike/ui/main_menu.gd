extends CanvasLayer

func _ready() -> void:
	$MainMenuMusic.play()

func _on_start_button_pressed() -> void:
	Game.start()
