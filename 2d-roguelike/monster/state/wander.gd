extends State

func enter(msg = null):
	actor.wander_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	actor.wander_timer.wait_time = actor.wander_time
	actor.wander_timer.start()

func exit():
	actor.velocity = Vector2.ZERO
	actor.wander_timer.stop()

func physics_update(delta):
	actor.velocity = actor.wander_direction * actor.speed
	actor.move_and_slide()

func update(delta):
	# Check if player is nearby
	if actor.player and actor.global_position.distance_to(actor.player.global_position) < actor.chase_distance:
		actor.state_machine.change_state(actor.state_machine.get_node("Charging"))

func _on_wander_timer_timeout() -> void:
	# Change direction or keep wandering
	actor.wander_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	actor.wander_timer.start()
