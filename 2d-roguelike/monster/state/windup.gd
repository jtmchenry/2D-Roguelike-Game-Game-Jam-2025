extends State

func enter(msg = null):
	actor.timer = actor.windup_duration
	print("Boss starts winding up...")

func physics_update(delta):
	actor.timer -= delta
	actor.velocity = Vector2.ZERO  # stay still during wind-up

	if actor.timer <= 0:
		if actor.player:
			actor.dash_direction = (actor.player.global_position - actor.global_position).normalized()
		else:
			actor.dash_direction = Vector2.RIGHT  # fallback direction
		actor.timer = actor.dash_duration
		actor.state_machine.change_state(actor.get_node("StateMachine/Dash"))
