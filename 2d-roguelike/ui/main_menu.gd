extends CanvasLayer

func _ready() -> void:
	AudioManager.play_music("res://audio/Undone.wav")

func _on_start_button_pressed() -> void:
	Game.start()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	$SettingsMenu.visible = true
	$TitleMenu.visible = false
