class_name Headlamp
extends Node3D

@export var camera: Node3D
@export var lerp_speed: float = 4

@onready var spotlight = $SpotLight3D

func _ready() -> void:
	spotlight.visible = false

func _physics_process(delta: float) -> void:
	spotlight.global_position = camera.global_position
	var target_basis = camera.global_transform.basis.orthonormalized()
	spotlight.global_transform.basis = spotlight.global_transform.basis.orthonormalized().slerp(target_basis, lerp_speed * delta)

func set_state(state: bool) -> void:
	spotlight.visible = state
