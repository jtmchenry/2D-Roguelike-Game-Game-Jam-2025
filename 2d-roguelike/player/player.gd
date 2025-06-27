extends CharacterBody2D
class_name Player

const SPEED = 500.0

@onready var health: Health = $Health
@onready var money: Money = $Money
@onready var animated_sprite = $AnimatedSprite2D

signal player_died

func _physics_process(delta):
	if Game.is_game_over:
		return
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	
	if velocity.x == 0 && velocity.y == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	if x_direction > 0:
		animated_sprite.flip_h = false
	elif x_direction < 0:
		animated_sprite.flip_h = true
	
	move_and_slide()
	return


func _on_health_died() -> void:
	animated_sprite.play("dead")
	emit_signal("player_died")
