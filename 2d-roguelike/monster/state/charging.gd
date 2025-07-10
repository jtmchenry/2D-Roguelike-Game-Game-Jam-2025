extends State

func enter(msg = null):
	actor.velocity = Vector2.ZERO
	actor.shoot_timer.wait_time = actor.charge_time
	actor.shoot_timer.start()

func exit():
	actor.shoot_timer.stop()

func physics_update(delta):
	actor.velocity = Vector2.ZERO

func _on_shoot_timer_timeout() -> void:
	actor.state_machine.change_state(actor.state_machine.get_node("Shoot"))
