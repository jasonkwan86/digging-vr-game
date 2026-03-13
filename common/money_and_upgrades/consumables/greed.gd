class_name Greed
extends Consumable

@export var greed_label: Label

var greed_time: float = 0

func _ready() -> void:
	super._ready()
	consumable_name = "Greed Potions"


func _physics_process(delta: float) -> void:
	if greed_time > 0:
		greed_time -= delta
		greed_label.text = "Greed: %0.2f" % greed_time
		greed_label.visible = true
	else:
		greed_label.visible = false


func use_item() -> void:
	greed_time = player.potion_duration
	player.money_and_upgrades.update_consumable_label()
