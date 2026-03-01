class_name Haste
extends Consumable

const HASTE_SPEED_BOOST: float = 2
const HASTE_JUMP_BOOST: float = 2

@export var controller: PlayerCameraAndMovementController
@export var haste_label: Label

var haste_time: float = 0

func _ready() -> void:
	super._ready()
	consumable_name = "Haste Potions"


func _physics_process(delta: float) -> void:
	if haste_time > 0:
		haste_time -= delta
		controller.speed = controller.base_speed + HASTE_SPEED_BOOST
		controller.jump_velocity = controller.base_jump_velocity + HASTE_JUMP_BOOST
		haste_label.text = "Haste: %0.2f" % haste_time
		haste_label.visible = true
	else:
		controller.speed = controller.base_speed
		controller.jump_velocity = controller.base_jump_velocity
		haste_label.visible = false


func use_item() -> void:
	haste_time = player.potion_duration
	player.money_and_upgrades.update_consumable_label()
