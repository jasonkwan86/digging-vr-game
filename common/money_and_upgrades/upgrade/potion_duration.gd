class_name PotionDuration
extends Upgrade

@export var effect_value: float

func buy_upgrade() -> void:
	player.potion_duration += effect_value
