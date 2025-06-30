extends Node2D
class_name Coin

@export var value: int = 1
var collected := false

func _ready():
	add_to_group("coins")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body.is_in_group("player") && body is Player:
		var player: Player = body
		player.money.earn(value)
		AudioManager.play_sfx("coin")
		collected = true
		if roll_for_heal_chance():
			player.health.heal(2)
		queue_free()

func roll_for_heal_chance() -> bool:
	var roll = randf()
	return roll < .20
