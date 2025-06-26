extends Node2D
class_name Coin

@export var value: int = 1
var collected := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body.is_in_group("player") && body is Player:
		var player: Player = body
		player.money.earn(value)
		collected = true
		queue_free()
