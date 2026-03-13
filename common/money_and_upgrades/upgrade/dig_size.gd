class_name DigSize
extends Upgrade

@export var effect_value: float

func buy_upgrade() -> void:
	player.dig_radius += effect_value
