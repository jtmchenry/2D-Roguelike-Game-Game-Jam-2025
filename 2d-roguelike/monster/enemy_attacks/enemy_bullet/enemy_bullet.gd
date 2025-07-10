extends Area2D

var velocity: Vector2 = Vector2.ZERO
@export var lifetime: float = 5.0

func setup(vel: Vector2):
	velocity = vel
	$Timer.wait_time = lifetime
	$Timer.start()

func _physics_process(delta):
	global_position += velocity * delta

func _on_timer_timeout() -> void:
	queue_free()
