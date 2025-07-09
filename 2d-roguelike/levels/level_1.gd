extends Node2D

@onready var game_over_modal = $GameOver

func _ready() -> void:
	AudioManager.play_music("res://audio/FleetStreetBeat.wav")

func _on_player_player_died() -> void:
	game_over_modal.show()
	Game.game_over()

func _on_music_player_finished() -> void:
	AudioManager.play_music("res://audio/FleetStreetBeat.wav")
