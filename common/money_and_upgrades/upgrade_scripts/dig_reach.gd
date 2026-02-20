class_name DigReach
extends Upgrade

@export var effect_value: float

func _init() -> void:
	is_repeating = false

func do_upgrade(player: Player) -> void:
	player.dig_reach += effect_value
	player.create_look_ray()
