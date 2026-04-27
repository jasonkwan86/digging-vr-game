class_name MineralInventory
extends Node

@export var mineral_title: Label
@export var mineral_ui: Label

var _mineral_count_in_inventory: Dictionary[MineralOnPickupStrategy, int]
var total_minerals_sold: Dictionary[MineralOnPickupStrategy, int]

var mineral_count: int:
	set(value):
		mineral_count = value
		mineral_ui.text = str(value)

func add_mineral_to_inventory(mineral_on_pickup_strategy: MineralOnPickupStrategy) -> void:
	_mineral_count_in_inventory[mineral_on_pickup_strategy] = _mineral_count_in_inventory.get(mineral_on_pickup_strategy, 0) + 1
	mineral_ui.text = str(sum_mineral_counts())
	
func sum_mineral_counts() -> int:
	if _mineral_count_in_inventory.keys().size() == 0:
		return 0
	return _mineral_count_in_inventory.values().reduce(func(accumulator, current_value): return accumulator + current_value)

func sum_mineral_sell_values() -> int:
	if _mineral_count_in_inventory.keys().size() == 0:
		return 0
	return _mineral_count_in_inventory.keys() \
		.map(func(mineral_on_pickup_strategy: MineralOnPickupStrategy): return mineral_on_pickup_strategy.sell_value * _mineral_count_in_inventory[mineral_on_pickup_strategy]) \
		.reduce(func(accumulator, current_value): return accumulator + current_value)

func sell_all_minerals() -> void:
	for mineral in _mineral_count_in_inventory:
		if total_minerals_sold.has(mineral):
			total_minerals_sold[mineral] += _mineral_count_in_inventory[mineral]
		else:
			total_minerals_sold[mineral] = _mineral_count_in_inventory[mineral]
		_mineral_count_in_inventory[mineral] = 0
	mineral_ui.text = str(sum_mineral_counts())

func change_label_colour(colour: Color):
	mineral_title.set("theme_override_colors/font_color", colour)
	mineral_ui.set("theme_override_colors/font_color", colour)
