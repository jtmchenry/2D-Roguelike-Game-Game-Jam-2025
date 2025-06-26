extends Area2D

func shoot():
	const BULLET = preload("res://player/Bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position

func _on_attack_speed_timeout() -> void:
	shoot();
