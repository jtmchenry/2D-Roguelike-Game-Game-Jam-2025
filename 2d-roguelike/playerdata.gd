extends Node

#Player Stats
var critical_damage_boost : float = 0
var critical_chance_boost : float = 0
var attack_speed_boost : float = 0
var weapon_range : int = 0
var damage_percentage_boost :float = 0
var health : int = 100

#Player Inventory
var money : int = 50
var equipped: Array = [true, false, false, false]

func reset_player_stats():
	critical_damage_boost = 0
	critical_chance_boost = 0
	attack_speed_boost = 0
	weapon_range = 0
	damage_percentage_boost = 0
	
	equipped = [true, false, false, false]
	
	money = 0

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
	if id == 6:
		var free_slots = get_indices_of_false_values(equipped)
		for weapon_number in free_slots:
			weapon_number
			equipped[weapon_number] = true
			print("Equipped weapon in slot ", weapon_number)
			return

func get_indices_of_false_values(arr: Array) -> Array:
	var indices = []
	for i in arr.size():
		if not arr[i]:
			indices.append(i)
	return indices
