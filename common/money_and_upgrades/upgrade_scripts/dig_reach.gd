class_name DigReach
extends Upgrade

@export var effect_value: float

func buy_upgrade() -> void:
	player.dig_reach += effect_value
	player.create_look_ray()
