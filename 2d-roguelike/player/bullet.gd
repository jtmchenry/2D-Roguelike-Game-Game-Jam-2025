extends Area2D

var travelled_distance = 0
@export var speed: float = 500.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float):
	const SPEED = 1000
	const RANGE = 350
	
	position += direction * SPEED * delta
	
	travelled_distance =+ SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
		

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.take_damage(1)
		queue_free()
