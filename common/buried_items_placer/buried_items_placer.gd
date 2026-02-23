class_name BuriedItemsPlacer
extends Node

@export var number_of_items_to_bury: int = 200
@export var set_of_items_to_bury: ItemsToBury
@export var vertical_displacement_from_top: float = 1.5

func place_buried_items(modifiable_ground: ModifiableGround) -> void:
	var global_min_x: float = modifiable_ground.global_position.x
	var global_max_x: float = modifiable_ground.global_position.x + modifiable_ground.WIDTH
	var global_min_y: float = modifiable_ground.global_position.y
	var global_max_y: float = modifiable_ground.global_position.y + modifiable_ground.HEIGHT - vertical_displacement_from_top
	var global_min_z: float = modifiable_ground.global_position.z
	var global_max_z: float = modifiable_ground.global_position.z + modifiable_ground.WIDTH
	for i in number_of_items_to_bury:
		var instantiated_item: Node3D = set_of_items_to_bury.items_to_bury.pick_random().instantiate()
		modifiable_ground.add_child(instantiated_item)
		
		instantiated_item.global_position = Vector3(
			randf_range(global_min_x, global_max_x),
			randf_range(global_min_y, global_max_y),
			randf_range(global_min_z, global_max_z)
		)
		instantiated_item.rotation = Vector3(
			randf_range(0, TAU),
			randf_range(0, TAU),
			randf_range(0, TAU),
		)
