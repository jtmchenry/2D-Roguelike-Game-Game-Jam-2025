extends Enemy

@export var dash_trigger_distance = 500.0
@export var windup_duration = 0.5
@export var dash_duration = 0.5
@export var dash_speed = 600.0

@onready var animated_sprite = $SlimeQueenAnimatedSprite

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
		
func take_damage(damage: int, critical: bool):	
	is_hurt = true
	animated_sprite.play("Hurt")
	if critical:
		await $Health.hit(damage, Color.MEDIUM_PURPLE);
	else:
		await $Health.hit(damage, Color.WHITE);
	if($Health.health <= 0):
		AudioManager.play_sfx("explosion")
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (_is_player(body)):
		_damage_player()
		damage_timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(_is_player(body)):
		damage_timer.stop()

func _on_slime_queen_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "Hurt":
		is_hurt = false
		animated_sprite.play("Idle")
	if animated_sprite.animation == "Spawning":
		is_spawning = false
		animated_sprite.play("Idle")
		state_machine.change_state(get_node("StateMachine/Approach"))
		
func _on_health_died() -> void:
	queue_free()
	
	print("Slime Queen was killed")
