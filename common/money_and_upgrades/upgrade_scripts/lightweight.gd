class_name Lightweight
extends Upgrade

@export var speed_increase: float
@export var jump_increase: float
@export var controller: PlayerCameraAndMovementController

func buy_upgrade() -> void:
	controller.base_speed += speed_increase
	controller.base_jump_velocity += jump_increase
