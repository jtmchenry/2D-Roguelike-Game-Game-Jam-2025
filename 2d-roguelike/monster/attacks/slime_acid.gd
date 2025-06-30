extends Area2D

@export var delay_before_damage : float = 0.5  # seconds before damage applies
@export var lifetime : float = 2.5  # seconds before node is freed

@export var damage : int = 50
@export var warning_time : float = .5  # time to warn player before damage

@onready var warning_sprite = get_node("WarningOfAttack")
@onready var attack_effect = get_node("SlimeAcidAttack")

func _ready():
	attack_effect.visible = false  # hide attack effect at start
	show_warning_then_attack()
	apply_aoe_damage_after_delay()
	queue_free_after_lifetime()

func show_warning_then_attack():
	# You could animate the warning sprite or blink it
	await get_tree().create_timer(warning_time).timeout

	# After warning, hide warning and show effect
	warning_sprite.visible = false
	attack_effect.visible = true

	# Apply damage now
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player") and body.has_method("apply_damage"):
			body.hurt_player()
			AudioManager.play_sfx("player_hurt")
			body.health.hit(damage, Color.RED)

func queue_free_after_lifetime():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func apply_aoe_damage_after_delay():
	await get_tree().create_timer(delay_before_damage).timeout
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player") and body.has_method("apply_damage"):
			body.apply_damage(damage)
