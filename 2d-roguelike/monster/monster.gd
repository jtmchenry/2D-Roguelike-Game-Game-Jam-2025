extends CharacterBody2D

@export var speed := 50.0
@export var damage := 50

@onready var player: Player = $"../Player"
@onready var collider = $CollisionShape2D
@onready var damage_timer = $Timer

func _ready() -> void:
	damage_timer.connect("timeout", _damage_player)
	add_to_group("Ememies")

func _physics_process(delta: float) -> void:
	if not player:
		return

	var direction = player.global_position - global_position
	if direction.length() > 5:  # stop moving when close
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

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
	player.health.hit(damage)
	return
	
