class_name BagSize
extends Upgrade

@export var effect_value: int

func _init() -> void:
	is_repeating = false

func do_upgrade(player: Player) -> void:
	player.bag_size += effect_value
