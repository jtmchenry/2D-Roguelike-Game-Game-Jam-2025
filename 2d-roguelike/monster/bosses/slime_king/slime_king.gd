extends Enemy

@onready var animated_sprite = $SlimeKingAnimatedSprite

func _ready():
	damage_timer.connect("timeout", _damage_player)
	add_to_group("Enemies")
	if not player:
		var players = get_tree().get_nodes_in_group("player")
		player = players[0]
	state_machine = $StateMachine

func _physics_process(delta: float):
	var direction = player.global_position - global_position
		
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (_is_player(body)):
		_damage_player()
		damage_timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(_is_player(body)):
		damage_timer.stop()

func _on_slime_king_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "Hurt":
		is_hurt = false
		animated_sprite.play("Idle")
	if animated_sprite.animation == "Spawning":
		animated_sprite.play("Idle")
		state_machine.change_state(get_node("StateMachine/Following"))
		

func _on_health_died() -> void:
	queue_free()
	
	print("Slime King was killed")
