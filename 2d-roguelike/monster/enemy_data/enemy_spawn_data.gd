extends Resource
class_name EnemySpawnData

@export var scene: PackedScene
@export var base_weight: float = 1.0
@export var level_scale: float = 0.1 # How much the weight increases per level
@export var max_weight: float = 10.0 # Cap so it doesn't get too high
@export var min_level: int = 1       # Enemy only starts spawning at this level
@export var default_max_health: int = 20
@export var default_damage: int = 10
@export var level_scale_health: float = 0.0
@export var level_scale_damage: float = 0.0
