class_name SellValue
extends Upgrade

@export var effect_value: float

func buy_upgrade() -> void:
	player.money_and_upgrades.sell_value += effect_value
