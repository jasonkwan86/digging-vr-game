class_name RocketConsumable
extends Consumable

func _ready() -> void:
	super._ready()
	consumable_name = "Rockets"
	usable = false
