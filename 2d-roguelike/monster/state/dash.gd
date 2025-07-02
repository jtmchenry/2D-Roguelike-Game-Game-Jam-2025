extends State

func physics_update(delta):
	actor.timer -= delta
	actor.velocity = actor.dash_direction * actor.dash_speed
	actor.move_and_slide()

	if actor.timer <= 0:
		actor.state_machine.change_state(actor.get_node("StateMachine/Approach"))
