class_name DigSize
extends Upgrade

@export var effect_value: float

func _init() -> void:
	is_repeating = false

func do_upgrade(player: Player) -> void:
	player.dig_radius += effect_value
