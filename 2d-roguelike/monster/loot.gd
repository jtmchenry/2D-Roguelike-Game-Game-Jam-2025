extends Node2D

@export var item_scene: PackedScene
@export var desapwn_after_seconds: float
@export var flicker_seconds_remaining: float 
@onready var despawn_timer = $DespawnTimer
@onready var flicker_timer = $FlickerTimer
@onready var start_flicker_timer = $StartFlickerTimer

func _ready():
	despawn_timer.wait_time = desapwn_after_seconds
	despawn_timer.start()
	start_flicker_timer.wait_time = desapwn_after_seconds - flicker_seconds_remaining
	start_flicker_timer.start()
	flicker_timer.wait_time = .25
	var item = item_scene.instantiate()
	add_child(item)

func _on_flicker_timer_timeout() -> void:
	if visible:
		hide()
	else:
		show()

func _on_despawn_timer_timeout() -> void:
	queue_free()

func _on_start_flicker_timer_timeout() -> void:
	flicker_timer.start()
