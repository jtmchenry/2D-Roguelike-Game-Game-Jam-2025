extends Node

var is_game_over = false
var current_level: int = 1
var last_level = 10

func start():
	is_game_over = false
	get_tree().change_scene_to_file(_current_level_scene_path())
	
func level_complete():
	var slime_king = get_tree().current_scene.get_node_or_null("SlimeKing")
	if slime_king != null:
		# There is a SlimeKing alive; wait until it's dead
		return
	var slime_queen = get_tree().current_scene.get_node_or_null("SlimeQueen")
	if slime_queen != null:
		# There is a SlimeQueen alive; wait until it's dead
		return
	if current_level == last_level:
		get_tree().change_scene_to_file("res://ui/victory.tscn")
		return
	current_level += 1
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.queue_free()
	get_tree().change_scene_to_file("res://ui/shop.tscn")

func upgrade_complete():
	get_tree().change_scene_to_file("res://ui/shop.tscn")

func shop_complete():
	get_tree().change_scene_to_file(_current_level_scene_path())

func game_over():
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.queue_free()
	is_game_over = true

func _current_level_scene_path() -> String:
	return "res://levels/level_%d.tscn" % current_level
