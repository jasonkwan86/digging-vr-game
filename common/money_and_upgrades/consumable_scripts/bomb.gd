class_name Bomb
extends Consumable

func _ready() -> void:
	super._ready()
	consumable_name = "Bombs"


func use_item() -> void:
	print("boom")
	player.money_and_upgrades.update_consumable_label()
