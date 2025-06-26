extends CharacterBody2D
class_name Player

const SPEED = 500.0

@onready var health: Health = $Health

func _physics_process(delta):
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	move_and_slide()
	return
