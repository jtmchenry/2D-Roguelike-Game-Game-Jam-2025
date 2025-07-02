extends Control

@onready var card_container = $CardContainer
@onready var detail_label = $DetailPanel/Details

@export var card_scene: PackedScene
@export var available_classes: Array[CharacterType]

var selected_class: CharacterType = null

func _ready():
	for cls in available_classes:
		var card = card_scene.instantiate()
		card.rpg_class = cls
		card.connect("pressed", Callable(self, "_on_card_pressed").bind(cls))
		card_container.add_child(card)

func _on_card_pressed(cls: CharacterType):
	selected_class = cls
	detail_label.text = "%s\nAbility: %s\nHealth: %d Mana: %d" % [
		cls.description, cls.special_ability, cls.base_health, cls.base_mana
	]

func _on_start_button_pressed():
	if selected_class:
		print("Starting game as %s" % selected_class.name)
		# save selected_class somewhere (global, singleton, etc.)
		get_tree().change_scene_to_file("res://game_scene.tscn")
