extends State

func enter(msg = null):
	actor.shoot()
	actor.state_machine.change_state(actor.state_machine.get_node("Wander"))

func exit():
	pass

func physics_update(delta):
	actor.velocity = Vector2.ZERO
