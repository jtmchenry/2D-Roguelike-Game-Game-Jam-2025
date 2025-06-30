extends CharacterBody2D
class_name Player

const SPEED = 500.0
var is_hurt = false
var is_invulnerable: bool = false

@onready var health: Health = $Health
@onready var money: Money = $Money
@onready var animated_sprite = $KnightAnimatedSprite
@onready var guns_slots: Array = [$Weapon, $Weapon2, $Weapon3, $Weapon4]

signal player_died
signal player_hurt

func _ready():
	# Sync visibility based on the equipped array
	for i in guns_slots.size():
		guns_slots[i].visible = Player1.equipped[i]

func _physics_process(delta):
	if Game.is_game_over:
		return
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	
	if not is_hurt:
		if velocity.x == 0 && velocity.y == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	
	if x_direction > 0:
		animated_sprite.flip_h = false
	elif x_direction < 0:
		animated_sprite.flip_h = true
	
	move_and_slide()
	return

func hurt_player(damage):
	if not is_invulnerable:
		is_hurt = true
		AudioManager.play_sfx("player_hurt")
		health.hit(damage, Color.RED)
		animated_sprite.play("hurt")
		is_invulnerable = true
		emit_signal("player_hurt")

func _on_health_died() -> void:
	animated_sprite.play("dead")
	emit_signal("player_died")

func _on_knight_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "hurt":
		is_invulnerable = false
		is_hurt = false
