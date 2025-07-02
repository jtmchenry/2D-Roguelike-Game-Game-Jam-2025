extends Node

@export var initial_state: NodePath
var current_state: State = null

func _ready():
	var actor = get_parent()
	for child in get_children():
		if child is State:
			child.actor = actor

	if initial_state != NodePath():
		current_state = get_node(initial_state)
		if current_state:
			current_state.enter()

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func change_state(new_state: State, msg = null):
	if current_state:
		current_state.exit()
	current_state = new_state
	if current_state:
		current_state.enter(msg)
