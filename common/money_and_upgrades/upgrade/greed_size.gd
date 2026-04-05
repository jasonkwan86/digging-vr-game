class_name GreedSize
extends Upgrade

@export var GreedRange: Area3D
@export var effect_value: float

func buy_upgrade() -> void:
	GreedRange.scale *= (1+effect_value)
