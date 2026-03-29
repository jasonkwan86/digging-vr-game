class_name Rocket
extends RigidBody3D

const ROCKET_RANGE_MOD: int = 4

@export var ROCKET_SPEED: int = 8

var dig_radius: float
var dig_strength: float
var move_range: float
var direction: Vector3

func configure(radius: float, strength: float, m_range: float, dir: Vector3, pos: Vector3) -> void:
	dig_radius = radius
	dig_strength = strength
	move_range = m_range * ROCKET_RANGE_MOD
	direction = dir
	
	global_position = pos

	look_at(global_position + dir, Vector3.UP)


func _physics_process(delta):
	global_position += direction * ROCKET_SPEED * delta
	
	move_range -= ROCKET_SPEED * delta
	if move_range <= 0:
		queue_free()


func _on_body_entered(body):
	if body is ModifiableGround:
		body.remove_from(global_position, dig_radius, dig_strength)
	queue_free()
