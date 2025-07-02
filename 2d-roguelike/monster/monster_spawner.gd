extends Node2D

@export var number_of_spawns = 0
@export var number_of_waves = 0
@export var spawn_scene: PackedScene
@export var radius: int = 1000
@export var monster_health_pool = 20
@export var player_scene = PackedScene #add a player scene when using this spawner.

@onready var wave_timer = $WaveTimer
@onready var within_wave_timer = $WithinWaveTimer
@onready var monster_container = $Monsters

signal all_monsters_killed

var spawns_per_wave = 0
var remaining_spawns = 0
var spawned_in_wave = 0

var player: Node2D = null

func _ready() -> void:
	randomize()
	if number_of_waves == 0:
		return
	spawns_per_wave = floor(number_of_spawns / number_of_waves)
	remaining_spawns = number_of_spawns
	player = get_parent().get_node("Player")
	
func _process(delta: float) -> void:
	if monster_container.get_children().is_empty() && remaining_spawns == 0:
		emit_signal("all_monsters_killed")

func _on_wave_timer_timeout() -> void:
	within_wave_timer.start()

func _on_within_wave_timer_timeout() -> void:
	if remaining_spawns == 0:
		wave_timer.stop()
		within_wave_timer.stop()
		return
	_spawn_monster()
	remaining_spawns -= 1
	spawned_in_wave += 1
	if spawned_in_wave == spawns_per_wave:
		within_wave_timer.stop()
		spawned_in_wave = 0

func _spawn_monster():
	var monster = spawn_scene.instantiate()
	monster.position = Vector2(
		randf_range(-radius / 2, radius / 2),
		randf_range(-radius / 2, radius / 2)
	)
	
		# Find the Health node in the monster and set its health
	var health_node = monster.get_node_or_null("Health")
	if health_node and health_node.has_method("set_health_value"):
		health_node.set_health_value(monster_health_pool)

	monster_container.add_child(monster)
