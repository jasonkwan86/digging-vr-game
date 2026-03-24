class_name Haste
extends Consumable

@export var controller: PlayerCameraAndMovementController
@export var haste_label: Label

var haste_speed_boost: float = 2
var haste_jump_boost: float = 2

var haste_time: float = 0

func _ready() -> void:
	super._ready()
	consumable_name = "Haste Potions"


func _physics_process(delta: float) -> void:
	if haste_time > 0:
		haste_time -= delta
		controller.speed = controller.base_speed + haste_speed_boost
		controller.jump_velocity = controller.base_jump_velocity + haste_jump_boost
		haste_label.text = "Haste: %0.2f" % haste_time
		haste_label.visible = true
	else:
		controller.speed = controller.base_speed
		controller.jump_velocity = controller.base_jump_velocity
		haste_label.visible = false


func use_item() -> void:
	haste_time = player.potion_duration
	player.money_and_upgrades.update_consumable_label()
