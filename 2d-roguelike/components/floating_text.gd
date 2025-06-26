extends Node2D

@export var float_speed := 30.0
@export var lifetime := 1.0

var velocity := Vector2.UP
var timer := 0.0

func _ready():
	timer = 0.0

func _process(delta):
	position += velocity * float_speed * delta
	timer += delta
	if timer >= lifetime:
		queue_free()

func set_text(value: String):
	$Label.text = value
