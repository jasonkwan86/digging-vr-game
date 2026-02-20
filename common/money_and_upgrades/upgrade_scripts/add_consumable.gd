class_name AddConsumable
extends Upgrade

@export var consumable: String
@export var num_to_add: int

func _init() -> void:
	is_repeating = true

func do_upgrade(player: Player) -> void:
	player.money_and_upgrades.add_consumable(consumable, num_to_add)
