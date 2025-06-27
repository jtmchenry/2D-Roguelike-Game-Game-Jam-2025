extends Control

func _ready():
	load_settings()

func _on_MasterSlider_value_changed(value):
	set_bus_volume("Master", value)

func _on_MusicSlider_value_changed(value):
	set_bus_volume("Music", value)

func _on_SFXSlider_value_changed(value):
	set_bus_volume("SFX", value)

func set_bus_volume(bus_name: String, value: float):
	var db = linear_to_db(value)
	var index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(index, db)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "master", $MasterVolumeSlider.value)
	config.set_value("audio", "music", $MusicVolumeSlider.value)
	config.set_value("audio", "sfx", $SFXVolumeSlider.value)
	config.save("user://settings.cfg")

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		return
	$MasterVolumeSlider.value = config.get_value("audio", "master", 1.0)
	$MusicVolumeSlider.value = config.get_value("audio", "music", 1.0)
	$SFXVolumeSlider.value = config.get_value("audio", "sfx", 1.0)


func _on_master_volume_slider_value_changed(value: float):
	set_bus_volume("Master", value)


func _on_music_volume_slider_value_changed(value: float):
	set_bus_volume("Music", value)


func _on_sfx_volume_slider_value_changed(value: float):
	set_bus_volume("SFX", value)

func _on_Back_pressed():
	save_settings()
	hide()  # Or go back to main menu
