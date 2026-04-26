class_name Drill
extends Tool

var dig_cooldown: float = 0

func check_input(delta: float) -> void:
	if Input.is_action_pressed("dig") and dig_cooldown <= 0:
		use_tool()
		dig_cooldown = 1/player.dig_speed
	
	if dig_cooldown > 0:
		dig_cooldown -= delta


func use_tool() -> void:
	var looking_at_object = player.looking_at_ray.get_collider()
	if looking_at_object is ModifiableGround:
		looking_at_object.try_remove_from(dig_power, player.looking_at_ray.get_collision_point(), player.dig_radius, dig_strength)
		var instantiated_mining_particles: Node3D = player.mining_particles.instantiate()
		get_tree().root.add_child(instantiated_mining_particles)
		instantiated_mining_particles.global_position = player.looking_at_ray.get_collision_point()
