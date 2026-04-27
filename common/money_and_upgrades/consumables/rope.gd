class_name Rope
extends Consumable

const STARTING_POSITION: Vector3 = Vector3(9,0.5,2)
const STARTING_ROTATION: Vector3 = Vector3(0,-90,0);
const STARTING_CAM_ROTATION: Vector3 = Vector3(-15,0,0)

const INPUT_LOCKOUT: float = 0.5

func _ready() -> void:
	super._ready()
	consumable_name = "Rope"


func use_item() -> void:
	var cam_controller = player.get_node("PlayerCameraAndMovementController")
	cam_controller.can_move = false
	player.velocity = Vector3.ZERO
	player.global_position = STARTING_POSITION
	player.rotation_degrees = STARTING_ROTATION
	cam_controller.camera.rotation_degrees = STARTING_CAM_ROTATION
	
	player.money_and_upgrades.update_consumable_label()
	
	await get_tree().create_timer(INPUT_LOCKOUT).timeout
	
	cam_controller.can_move = true
