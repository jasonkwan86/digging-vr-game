class_name Mineral
extends RigidBody3D

@export var fall_detection_area: Area3D

func _ready() -> void:
	fall_detection_area.body_exited.connect(handle_mineral_exited_buried)

func handle_mineral_exited_buried(_body: Node3D) -> void:
	freeze = false
