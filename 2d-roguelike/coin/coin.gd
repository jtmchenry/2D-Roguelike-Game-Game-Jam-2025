extends Node2D
class_name Coin

#ADD SOUNDS MANAGE CLASS TO DECOUPLE
@onready var level = get_tree().current_scene
@onready var sfx_player = level.get_node("SFXPlayer")

@export var value: int = 1
var collected := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body.is_in_group("player") && body is Player:
		var player: Player = body
		player.money.earn(value)
		if sfx_player:
			sfx_player.stream = load("res://audio/coin.wav")
			sfx_player.play()
		collected = true
		queue_free()
