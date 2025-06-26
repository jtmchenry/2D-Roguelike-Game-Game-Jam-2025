extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	
	var bullet_direction = Vector2.RIGHT.rotated(rotation)
	position += bullet_direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	#Add Damage to Monster Ememy Here


func _on_timer_timeout() -> void:
	pass # Replace with function body.
