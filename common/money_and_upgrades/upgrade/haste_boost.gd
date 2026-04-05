class_name HasteBoost
extends Upgrade

@export var haste_potion: Haste
@export var effect_value: float

func buy_upgrade() -> void:
	haste_potion.haste_speed_boost += effect_value
	haste_potion.haste_jump_boost += effect_value
