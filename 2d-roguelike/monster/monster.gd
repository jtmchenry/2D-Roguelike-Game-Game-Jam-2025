extends CharacterBody2D

@export var speed := 50.0
@onready var player = $"../Player"

func _physics_process(delta: float) -> void:
	print(player)
	if not player:
		return

	var direction = player.global_position - global_position
	if direction.length() > 5:  # stop moving when close
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
