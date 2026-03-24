class_name Bomb
extends RigidBody3D

const FUSE: float = 3.0
const STARTING_VELOCITY: float = 6
const BOMB_SIZE_MOD = 2

var dig_radius: float
var dig_strength: float
var direction: Vector3

var detonation_area: Area3D

var time_active: float = 0

func configure(radius: float, strength: float, dir: Vector3, pos: Vector3) -> void:
	dig_radius = radius * BOMB_SIZE_MOD
	dig_strength = strength
	direction = dir

	global_position = pos
	
	detonation_area = $DetonationArea
	
	look_at(global_position+dir, Vector3.UP)
	linear_velocity = -transform.basis.z * STARTING_VELOCITY

func _process(delta: float) -> void:
	time_active += delta
	if time_active >= FUSE:
		var colliding = detonation_area.get_overlapping_bodies()
		for body in colliding:
			if body is ModifiableGround:
				body.remove_from(global_position, dig_radius, dig_strength)
		queue_free()
