extends Area2D

@export var bullet_scene: PackedScene
var base_weapon_range: float = 200
var base_weapon_damage: int = 10
var base_critical_chance: float = .1
var base_critical_damage: float = 50
var base_fire_rate: float = .5

var current_weapon_range: float = base_weapon_range
var current_weapon_damage: int = base_weapon_damage
var current_critical_chance: float = base_critical_chance
var current_critical_damage: float = base_critical_damage

var fire_timer: float = 0.0

func _ready():
	position += Vector2(1, -2).normalized() * 20

func _process(delta):
	calc_buffed_stats()
	if Game.is_game_over:
		return
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		shape.radius += current_weapon_range
		
	fire_timer -= delta
	var target = get_nearest_enemy_in_area()
	
	if target:
		var direction = target.global_position - global_position
		rotation = direction.angle()
	
	if target and fire_timer <= 0:
		fire_timer = base_fire_rate
		shoot(target)

func get_nearest_enemy_in_area() -> CharacterBody2D:
	var closest_enemy: CharacterBody2D = null
	var closest_distance = INF
	for body in get_overlapping_bodies():
		if body.is_in_group("Enemies"):
			var dist = global_position.distance_to(body.global_position)
			if dist < closest_distance:
				closest_distance = dist
				closest_enemy = body
	return closest_enemy

func shoot(target: CharacterBody2D):
	if bullet_scene == null:
		return
	AudioManager.play_sfx("res://audio/tap.wav")
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = (target.global_position - global_position).normalized()
	var critical = roll_for_chance(current_critical_chance)
	var damage = current_weapon_damage
	bullet.critical = false
	if critical:
		bullet.critical = critical
		damage = current_weapon_damage * (1 + current_critical_damage / 100.0)
	bullet.damage = damage
	get_tree().current_scene.add_child(bullet)

func calc_buffed_stats():
	current_critical_chance = base_critical_chance + Player1.critical_chance_boost
	current_critical_damage = base_critical_damage + Player1.critical_damage_boost
	current_weapon_range = base_weapon_range + Player1.weapon_range
	current_weapon_damage = base_weapon_damage * (1 + Player1.damage_percentage_boost / 100.0)

func roll_for_chance(critical_chance: float) -> bool:
	var roll = randf()
	return roll > critical_chance
