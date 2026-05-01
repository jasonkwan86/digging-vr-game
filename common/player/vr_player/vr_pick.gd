class_name VrPick
extends Node3D

@export var pick_cooldown: float = 0.5
@export var required_velocity_to_mine: float = 4
@export var pick_raycast: RayCast3D

var last_position: Vector3 = Vector3.ZERO
var velocity: Vector3 = Vector3.ZERO
var seconds_after_last_mine: float = 0

func _process(delta: float) -> void:
	seconds_after_last_mine += delta
	
	velocity = (transform.origin - last_position) / delta
	last_position = transform.origin
	
	if velocity.length() < required_velocity_to_mine:
		return
	if seconds_after_last_mine < pick_cooldown:
		return
	
	var ray_col = pick_raycast.get_collider()
	if ray_col is ModifiableGround:
		ray_col.try_remove_from(99, pick_raycast.get_collision_point(), 2, 2)
		seconds_after_last_mine = 0
	if ray_col is FinalTreasure:
		(ray_col as FinalTreasure).open_treasure()
		print("Opening Final treasure!")
