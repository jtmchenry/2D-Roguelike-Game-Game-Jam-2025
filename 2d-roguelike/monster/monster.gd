extends CharacterBody2D

#@export var floating_text_scene: PackedScene

@export var speed := 50.0
@export var damage := 10
@export var loot_scene: PackedScene

@onready var player: Player = $"../Player"
@onready var collider = $CollisionShape2D
@onready var damage_timer = $Timer
@onready var animated_sprite = $MonsterAnimatedSprite
@onready var health_control = $Health

var is_hurt = false

#Lol dashing
var is_dashing: bool = false
var dash_timer: float = 0.0
var cooldown_timer: float = 0.0
var dash_direction: Vector2 = Vector2.ZERO

@export var move_speed: float = 200.0       # Speed when approaching
@export var dash_speed: float = 600.0       # Speed during dash
@export var dash_duration: float = 1      # How long the dash lasts
@export var windup_time: float = 0.5        # How long the monster waits before dashing
@export var dash_trigger_distance: float = 200.0 # Start wind-up when this close to player

enum State { FOLLOW }
var current_state = State.FOLLOW

var timer: float = 0.0

func _ready() -> void:
	damage_timer.connect("timeout", _damage_player)
	add_to_group("Enemies")
	if not player:
		var players = get_tree().get_nodes_in_group("player")
		player = players[0]

func _physics_process(delta: float) -> void:
	if Game.is_game_over:
		return
	
	if not player:
		return
	
	if not is_hurt:
		animated_sprite.play("idle")
		
	match current_state:
		State.FOLLOW:
			approach_player(delta)
	
	var direction = player.global_position - global_position
		
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
		
func _on_monster_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "hurt":
		is_hurt = false

func _is_player(body: Node2D) -> bool:
	return player == body
	
func _damage_player() -> void:
	if Game.is_game_over:
		return
	player.hurt_player(damage)
	return
	
func take_damage(damage: int, critical: bool):	
	animated_sprite.play("hurt")
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

func approach_player(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()
