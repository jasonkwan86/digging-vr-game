class_name Rocket
extends RigidBody3D

var speed: float
var dig_radius: float
var dig_strength: float
var move_range: float
var direction: Vector3

func configure(spd: float, radius: float, strength: float, range: float, dir: Vector3, pos: Vector3) -> void:
	speed = spd
	dig_radius = radius
	dig_strength = strength
	move_range = range
	direction = dir
	
	global_position = pos

	look_at(global_position + dir, Vector3.UP)


func _physics_process(delta):
	# Move in direction
	global_position += direction * speed * delta
	
	move_range -= speed * delta
	if move_range <= 0:
		queue_free()


func _on_body_entered(body):
	if body is ModifiableGround:
		body.remove_from(global_position, dig_radius, dig_strength)
	queue_free()  # Remove projectile
