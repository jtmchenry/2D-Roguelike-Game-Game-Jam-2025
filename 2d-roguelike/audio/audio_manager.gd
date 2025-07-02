extends Node

var music_player: AudioStreamPlayer

var sfx_players := {} 

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	add_child(music_player)
	music_player.bus = "Music"
	music_player.autoplay = false
	
	_create_sfx_player("shoot", "res://audio/tap.wav")
	_create_sfx_player("explosion", "res://audio/explosion.wav")
	_create_sfx_player("coin", "res://audio/coin.wav")
	_create_sfx_player("player_hurt", "res://audio/player/hurt.wav")

func _create_sfx_player(song_name: String, stream_path: String):
	var player = AudioStreamPlayer.new()
	player.stream = load(stream_path)
	player.bus = "SFX"  # make sure you have a SFX bus
	add_child(player)
	sfx_players[song_name] = player

func play_music(music_file: String):
	if music_file == null:
		print("Error: Music file is null!")
		return
	var music_player_stream = load(music_file)
	music_player.stream = music_player_stream
	music_player.play()

func play_sfx(name: String):
	var sfx_player = sfx_players[name]
	print("playing " + name + " sound effect")
	sfx_player.play()


func _on_music_player_finished() -> void:
	music_player.play()
