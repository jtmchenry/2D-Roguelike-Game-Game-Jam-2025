extends Label
@onready var CurrentLevel = $"."

func _ready() -> void:
	CurrentLevel.text =  "Level " + str(Game.current_level)
