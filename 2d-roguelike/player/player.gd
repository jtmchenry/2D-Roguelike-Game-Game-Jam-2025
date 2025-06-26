extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta):
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	print(x_direction, y_direction)
	velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	move_and_slide()
	return
