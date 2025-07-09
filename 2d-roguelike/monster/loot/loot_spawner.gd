extends Node
class_name LootSpawner

@export var coin_scene: PackedScene

# Spawns coins at a given world position
# - position: where to spawn around
# - count: how many coins to spawn (default 3)
# - spread_radius: max distance from center position to randomize coins
func spawn_coins_at(position: Vector2, count: int = 3, spread_radius: float = 75.0):
	if coin_scene == null:
		push_error("CoinSpawner: coin_scene is not assigned!")
		return

	for i in range(count):
		var coin = coin_scene.instantiate()
		var offset = Vector2(randf_range(-spread_radius, spread_radius), randf_range(-spread_radius, spread_radius))
		coin.global_position = position + offset
		# Add directly to current scene so coins aren't tied to the spawner's transform
		get_tree().current_scene.add_child(coin)
