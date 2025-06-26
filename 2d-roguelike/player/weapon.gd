extends Area2D

@export var fire_rate: float = 0.5
@export var bullet_scene: PackedScene
@export var weapon_range: float = 200
@export var weapon_damage: int = 20
@export var critical_chance: float = .5
@export var critical_damage: float = 1.25

var fire_timer: float = 0.0

func _process(delta):
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		shape.radius += weapon_range
		
	fire_timer -= delta
	var target = get_nearest_enemy_in_area()
	
	if target and fire_timer <= 0:
		fire_timer = fire_rate
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
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = (target.global_position - global_position).normalized()
	bullet.damage = calc_damage(weapon_damage)
	get_tree().current_scene.add_child(bullet)

func calc_damage(damage: int) -> int:
	return damage
