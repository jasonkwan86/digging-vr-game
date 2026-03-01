class_name BagSize
extends Upgrade

@export var effect_value: int

func buy_upgrade() -> void:
	player.bag_size += effect_value
