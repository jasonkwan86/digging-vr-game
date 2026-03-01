class_name AddConsumable
extends Upgrade

@export var consumable: Consumable
@export var num_to_add: int

func _init() -> void:
	is_repeating = true


func buy_upgrade() -> void:
	consumable.add(num_to_add)
