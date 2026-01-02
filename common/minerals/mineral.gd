class_name Mineral
extends RigidBody3D

@export_group("Mineral")
@export var mineral_properties: MineralProperties
@export var mesh: MeshInstance3D
@export var interactable_highlight: StandardMaterial3D

@export_group("Fall Detection")
@export var fall_detection_area: Area3D

var is_being_looked_at_this_frame: bool

func _ready() -> void:
	freeze = true
	fall_detection_area.body_exited.connect(handle_mineral_exited_buried)

func handle_mineral_exited_buried(_body: Node3D) -> void:
	freeze = false

func mineral_being_looked_at():
	is_being_looked_at_this_frame = true

func _process(_delta: float) -> void:
	if is_being_looked_at_this_frame:
		if mesh.material_overlay == null:
			mesh.material_overlay = interactable_highlight
	else:
		mesh.material_overlay = null
	is_being_looked_at_this_frame = false
