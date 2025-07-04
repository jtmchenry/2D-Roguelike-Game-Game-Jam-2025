extends State

func physics_update(delta):
	if not actor.player:
		return

	var to_player = actor.player.global_position - actor.global_position
	actor.velocity = to_player.normalized() * actor.move_speed
	actor.move_and_slide()
