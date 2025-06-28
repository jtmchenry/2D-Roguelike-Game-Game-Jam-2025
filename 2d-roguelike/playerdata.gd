extends Node

#Player Stats
var critical_damage_boost = 0
var critical_chance_boost = 0
var attack_speed_boost = 0
var weapon_range = 0
var damage_percentage_boost = 0
var health = 100

#Player Inventory
var money = 0


func update_player_stats_on_upgrade(id: int, value: int):
	if id == 1:
		damage_percentage_boost += value
	if id == 2:
		attack_speed_boost += value
	if id == 3:
		critical_damage_boost += value
	if id == 4:
		critical_chance_boost += value
	if id == 5:
		weapon_range += value
