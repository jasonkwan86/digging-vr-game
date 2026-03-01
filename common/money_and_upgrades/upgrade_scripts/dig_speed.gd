class_name DigSpeed
extends Upgrade

@export var effect_value: float

func buy_upgrade() -> void:
	player.dig_speed += effect_value
