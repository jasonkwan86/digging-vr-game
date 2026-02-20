class_name DigSpeed
extends Upgrade

@export var effect_value: float

func _init() -> void:
	is_repeating = false

func do_upgrade(player: Player) -> void:
	player.dig_speed += effect_value
