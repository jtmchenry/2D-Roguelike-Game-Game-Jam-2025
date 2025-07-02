extends CharacterBody2D
class_name Enemy

@export var damage := 10
@export var loot_scene: PackedScene
@export var speed = 200.0
@export var chase_distance = 200.0
@export var move_speed = 150.0

var player: CharacterBody2D = null
var state_machine: Node = null
var dash_direction = Vector2.ZERO
var timer = 0.0

@onready var damage_timer = $Timer
@onready var health_control = $Health

var is_hurt = false

func _is_player(body: Node2D) -> bool:
	return player == body
	
func _damage_player() -> void:
	if Game.is_game_over:
		return
	player.hurt_player(damage)
	return
	
func take_damage(damage: int, critical: bool):	
	is_hurt = true
	if critical:
		await $Health.hit(damage, Color.MEDIUM_PURPLE);
	else:
		await $Health.hit(damage, Color.WHITE);
	if($Health.health <= 0):
		AudioManager.play_sfx("explosion")
		drop_loot()
		queue_free()
		
func drop_loot():
	var number = randf_range(1, 5)
	for i in range(number):
		var l = loot_scene.instantiate()
		var x = randf_range(-75, 75)
		var y = randf_range(-75, 75)
		l.global_position = global_position + Vector2(x, y)
		get_tree().get_root().add_child(l)

func set_health_value(monster_health: int):
	health_control.set_health_value(monster_health)
