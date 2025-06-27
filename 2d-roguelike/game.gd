extends Node

var current_level: int = 1
var last_level = 1

func start():
	get_tree().change_scene_to_file(_current_level_scene_path())
	
func level_complete():
	if current_level == last_level:
		get_tree().change_scene_to_file("res://ui/victory.tscn")
		return
	current_level += 1
	get_tree().change_scene_to_file("res://ui/upgrade.tscn")
	
func upgrade_complete():
	get_tree().change_scene_to_file("res://ui/shop.tscn")
	
func shop_complete():
	get_tree().change_scene_to_file(_current_level_scene_path())
	
func _current_level_scene_path() -> String:
	return "res://levels/level_%d.tscn" % current_level
