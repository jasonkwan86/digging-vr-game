class_name Upgrade
extends Resource

@export var upgrade_name: String
@export var cost: int
@export_enum("unlock_tool", "unlock_merchant", "dig_speed", "dig_radius", "dig_reach", "bag_size", "sell_value", "speed", "jump_velocity", "add_consumable") 
var effect_type: String
@export var effect_value: float
@export var next_upgrade: Upgrade
@export var consumable_id: int # -1 if not consumable
