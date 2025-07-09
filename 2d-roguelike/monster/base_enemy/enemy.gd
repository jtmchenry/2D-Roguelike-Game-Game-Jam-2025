extends CharacterBody2D
class_name Enemy

@export var damage := 10
@export var loot_scene: PackedScene
@export var speed = 200.0
@export var chase_distance = 200.0
@export var move_speed = 150.0

var player: CharacterBody2D = null
var state_machine: Node = null
var dash_direction = Vector2.ZERO
var timer = 0.0

@onready var damage_timer = $Timer
@onready var health_control = $Health

var is_hurt = false
var is_spawning = true

func _is_player(body: Node2D) -> bool:
	return player == body
	
func _damage_player() -> void:
	if Game.is_game_over or is_spawning:
		return
	player.hurt_player(damage)
	return

func set_health_value(monster_health: int):
	health_control.set_health_value(monster_health)
	
func reset():
	show()
	is_hurt = false
	is_spawning = false
	health_control.set_health_value(health_control.max_health)
	state_machine.change_state(get_node("StateMachine/Spawning"))
	# reset any other state here (timer, animations, etc)
