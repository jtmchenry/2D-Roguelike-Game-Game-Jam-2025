extends Node

var is_game_over = false
var current_level: int = 1
var last_level = 10

func start():
	is_game_over = false
	get_tree().change_scene_to_file(_current_level_scene_path())
	
func level_complete():
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

func game_shop_item_price_scaling(base_price : int) -> int:
	if current_level == 2: #Dont scale on the first shop
		return base_price
	var current_value : int = (base_price + (current_level - 1) + (base_price * 0.1 * (current_level - 1)))
	return current_value
