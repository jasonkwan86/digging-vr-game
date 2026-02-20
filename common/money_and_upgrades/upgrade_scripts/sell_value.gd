class_name SellValue
extends Upgrade

@export var effect_value: float

func _init() -> void:
	is_repeating = false

func do_upgrade(player: Player) -> void:
	player.money_and_upgrades.sell_value += effect_value
