extends Node2D

var travelled_distance = 0
@export var speed: float = 1000.0
@export var range: float = 350.0
@export var damage: int = 1
@export var critical: bool = false
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float):

	position += direction * speed * delta
	
	travelled_distance =+ speed * delta
	
	if travelled_distance > range:
		queue_free()
		

func _on_bullet_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		if body.has_method("take_damage"):
			body.take_damage(damage, critical)
		queue_free()  # destroy bullet
