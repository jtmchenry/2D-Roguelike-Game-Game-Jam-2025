extends Node

var current_level: int = 1
var last_level = 5

func start():
	get_tree().change_scene_to_file(_current_level_scene_path())
	
func level_complete():
	if current_level == last_level:
		print("You beat the game!")
		return
	current_level += 1
	get_tree().change_scene_to_file("res://upgrade.tscn")
	
func upgrade_complete():

	get_tree().change_scene_to_file("res://shop.tscn")
	
func shop_complete():
	get_tree().change_scene_to_file(_current_level_scene_path())
	
func _current_level_scene_path() -> String:
	return "res://levels/level_%d.tscn" % current_level
