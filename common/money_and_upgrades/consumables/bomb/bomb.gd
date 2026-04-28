class_name Bomb
extends RigidBody3D

const FUSE: float = 3.0
const STARTING_VELOCITY: float = 6
const BOMB_SIZE_MOD = 2

@export var bomb_flash: ShaderMaterial

var dig_power: int
var dig_radius: float
var dig_strength: float
var direction: Vector3
var detonation_area: Area3D
var time_active: float = 0

func configure(power: int, radius: float, strength: float, dir: Vector3, pos: Vector3) -> void:
	dig_power = power
	dig_radius = radius * BOMB_SIZE_MOD
	dig_strength = strength
	direction = dir
	global_position = pos
	detonation_area = $DetonationArea
	look_at(global_position+dir, Vector3.UP)
	linear_velocity = -transform.basis.z * STARTING_VELOCITY

func _process(delta: float) -> void:
	time_active += delta
	# kind of magic numbers but just clamps range to (0,1)
	bomb_flash.set_shader_parameter("flash_strength", (-cos(6 * time_active**2) + 1)/2)
	if time_active >= FUSE:
		var colliding = detonation_area.get_overlapping_bodies()
		for body in colliding:
			if body is ModifiableGround:
				body.try_remove_from(dig_power, global_position, dig_radius, dig_strength)
		queue_free()
