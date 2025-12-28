class_name MineralInventory
extends Node

@export var _mineral_count_in_inventory: Dictionary[MineralProperties, int]

@export var mineral_ui: Label

# TODO: Replace with maybe a list/dict to keep track of owned minerals
var mineral_count: int:
	set(value):
		mineral_count = value
		mineral_ui.text = str(value)

func add_mineral_to_inventory(mineral: Mineral) -> void:
	_mineral_count_in_inventory[mineral.mineral_properties] = _mineral_count_in_inventory.get(mineral.mineral_properties, 0) + 1
	mineral_ui.text = str(sum_mineral_counts())
	
func sum_mineral_counts() -> int:
	return _mineral_count_in_inventory.values().reduce(func(accumulator, current_value): return accumulator + current_value)

func sum_mineral_sell_values() -> int:
	return _mineral_count_in_inventory.keys() \
		.map(func(mineral_property: MineralProperties): return mineral_property.sell_value * _mineral_count_in_inventory[mineral_property]) \
		.reduce(func(accumulator, current_value): return accumulator + current_value)

func sell_all_minerals() -> void:
	for mineral in _mineral_count_in_inventory:
		_mineral_count_in_inventory[mineral] = 0
