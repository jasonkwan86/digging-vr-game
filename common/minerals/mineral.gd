class_name Mineral
extends RigidBody3D

@export_group("Mineral")
@export var mineral_properties: MineralProperties

@export_group("Fall Detection")
@export var fall_detection_area: Area3D

func _ready() -> void:
	freeze = true
	fall_detection_area.body_exited.connect(handle_mineral_exited_buried)

func handle_mineral_exited_buried(_body: Node3D) -> void:
	freeze = false
