extends Node

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	add_child(music_player)
	music_player.bus = "Music"
	music_player.autoplay = false
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.name = "SFXPlayer"
	add_child(sfx_player)
	sfx_player.bus = "SFX"
	sfx_player.autoplay = false

func play_music(music_file: String):
	if music_file == null:
		print("Error: Music file is null!")
		return
	var music_player_stream = load(music_file)
	music_player.stream = music_player_stream
	music_player.play()

func play_sfx(sfx_file: String):
	if sfx_file == null:
		print("Error: Music file is null!")
		return
	var sfx_player_stream = load(sfx_file)
	sfx_player.stream = sfx_player_stream
	sfx_player.play()


func _on_music_player_finished() -> void:
	music_player.play()
