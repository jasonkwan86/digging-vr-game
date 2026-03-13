class_name Rope
extends Consumable

const STARTING_POSITION: Vector3 = Vector3(9,1,2)

func _ready() -> void:
	super._ready()
	consumable_name = "Rope"


func use_item() -> void:
	player.global_position = STARTING_POSITION
	player.money_and_upgrades.update_consumable_label()
