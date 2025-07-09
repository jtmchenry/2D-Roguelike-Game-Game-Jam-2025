extends State

func physics_update(delta):
	if not actor.player:
		return
		
	actor.animated_sprite.play("Spawning")
