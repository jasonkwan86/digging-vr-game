@tool
class_name WoodPlank
extends StaticBody3D

@export_range(1, 32) var plank_length: float = 16:
	set(value):
		plank_length = value
		if Engine.is_editor_hint():
			plank_mesh.size.z = value
			plank_collider_shape.size.z = value

@export var plank_mesh: BoxMesh
@export var plank_collider_shape: BoxShape3D
