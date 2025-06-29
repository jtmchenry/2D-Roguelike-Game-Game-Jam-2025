extends CharacterBody2D

#@export var floating_text_scene: PackedScene

@export var speed := 50.0
@export var damage := 10
@export var loot_scene: PackedScene

@onready var player: Player = $"../Player"
@onready var collider = $CollisionShape2D
@onready var damage_timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var health_control = $Health

func _ready() -> void:
	damage_timer.connect("timeout", _damage_player)
	add_to_group("Enemies")

func _physics_process(delta: float) -> void:
	if Game.is_game_over:
		return
	if not player:
		var players = get_tree().get_nodes_in_group("player")
		player = players[0]
	
	if not player:
		return

	var direction = player.global_position - global_position
	if direction.length() > 5:  # stop moving when close
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (_is_player(body)):
		_damage_player()
		damage_timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(_is_player(body)):
		damage_timer.stop()

func _is_player(body: Node2D) -> bool:
	return player == body
	
func _damage_player() -> void:
	if Game.is_game_over:
		return
	AudioManager.play_sfx("player_hurt")
	player.health.hit(damage, Color.RED)
	return
	
func take_damage(damage: int, critical: bool):	
	if critical:
		await $Health.hit(damage, Color.MEDIUM_PURPLE);
	else:
		await $Health.hit(damage, Color.WHITE);
	if($Health.health <= 0):
		AudioManager.play_sfx("explosion")
		drop_loot()
		queue_free()
		
func drop_loot():
	for i in range(8):
		var l = loot_scene.instantiate()
		var x = randf_range(-75, 75)
		var y = randf_range(-75, 75)
		l.global_position = global_position + Vector2(x, y)
		get_tree().get_root().add_child(l)

func set_health_value(monster_health: int):
	health_control.set_health_value(monster_health)
