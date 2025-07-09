extends Node2D
#New Spawner Code
@export var enemy_spawn_data: Array[EnemySpawnData]
@export var spawn_interval: float = 2.0
@export var max_active_monsters: int = 10
@export var max_monsters: int = 50

@onready var loot_spawner: Node2D = $"../LootSpawner"

var active_monsters: Array[Node2D] = []
var enemy_pools: Dictionary = {}
var spawn_timer: Timer

var total_spawned: int = 0
var total_killed: int = 0

signal all_monsters_killed

func _ready():
	randomize()
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	spawn_timer.start()

	for data in enemy_spawn_data:
		enemy_pools[data.scene] = []

func _on_spawn_timer_timeout():
	spawn_enemy_by_weight()
	
	if total_spawned >= max_monsters:
		spawn_timer.stop()


func spawn_enemy_by_weight():
	if active_monsters.size() >= max_active_monsters:
		return

	var available: Array = []
	var weights: Array = []
	var total_weight = 0.0

	for data in enemy_spawn_data:
		if Game.current_level >= data.min_level:
			var weight = data.base_weight + data.level_scale * Game.current_level
			weight = min(weight, data.max_weight)
			if weight > 0:
				available.append(data)
				weights.append(weight)
				total_weight += weight

	if available.is_empty():
		print("No enemies available to spawn.")
		return

	var rnd = randf() * total_weight
	var sum = 0.0

	for i in range(available.size()):
		sum += weights[i]
		if rnd <= sum:
			var data = available[i]
			var enemy = get_enemy_instance(data)
			
			# Set position randomly around spawner
			enemy.global_position = global_position + Vector2(randf_range(-800,800), randf_range(-800,800))

			# Set health from data
			var health_node = enemy.get_node_or_null("Health")
			if health_node:
				health_node.max_health = data.default_max_health * pow(data.level_scale_health, (Game.current_level - 1))
				health_node.health = data.default_max_health * pow(data.level_scale_damage, (Game.current_level - 1))

			enemy.show()
			get_tree().current_scene.add_child(enemy)
			active_monsters.append(enemy)
			
			if enemy.has_method("reset"):
				enemy.reset()
			break

func get_enemy_instance(data: EnemySpawnData) -> Node2D:
	var pool = enemy_pools[data.scene]
	if pool.size() > 0:
		return pool.pop_back()
	else:
		var instance = data.scene.instantiate()
		# Find Health node and connect died signal
		var health_node = instance.get_node_or_null("Health")
		if health_node:
			if not health_node.is_connected("died", Callable(self, "_on_enemy_died")):
				health_node.connect("died", Callable(self, "_on_enemy_died").bind(data.scene, instance))
		return instance

func _on_enemy_died(scene: PackedScene, enemy: Node2D):
	loot_spawner.spawn_coins_at(enemy.global_position)
	if enemy.get_parent():
		enemy.get_parent().remove_child(enemy)
	enemy.hide()
	enemy_pools[scene].append(enemy)
	active_monsters.erase(enemy)
	
	total_killed += 1 
	
	check_all_monsters_killed()

func check_all_monsters_killed() -> void:
	if total_killed >= max_monsters:
		emit_signal("all_monsters_killed")
		Game.level_complete()

func reset_spawner():
	active_monsters.clear()
	enemy_pools.clear()
