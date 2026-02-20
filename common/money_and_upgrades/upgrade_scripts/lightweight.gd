class_name Lightweight
extends Upgrade

@export var speed_increase: float
@export var jump_increase: float

func _init() -> void:
	is_repeating = false

func do_upgrade(player: Player) -> void:
	player.camera_and_movement_controller.speed += speed_increase
	player.camera_and_movement_controller.jump_velocity += jump_increase
