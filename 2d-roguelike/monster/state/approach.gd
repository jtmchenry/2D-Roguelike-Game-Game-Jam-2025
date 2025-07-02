extends State

func physics_update(delta):
	if not actor.player:
		return

	var to_player = actor.player.global_position - actor.global_position
	if to_player.length() <= actor.dash_trigger_distance:
		# Close enough: start wind-up before dash
		actor.timer = actor.windup_duration
		actor.velocity = Vector2.ZERO
		actor.state_machine.change_state(actor.get_node("StateMachine/WindUp"))
	else:
		# Move toward player
		actor.velocity = to_player.normalized() * actor.move_speed
		actor.move_and_slide()
