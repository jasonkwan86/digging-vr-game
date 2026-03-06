class_name DefaultTool
extends Tool

func check_input(_delta: float) -> void:
	if Input.is_action_just_pressed("dig"):
		use_tool()


func use_tool() -> void:
	var looking_at_object = player.looking_at_ray.get_collider()
	if looking_at_object is ModifiableGround:
		looking_at_object.remove_from(player.looking_at_ray.get_collision_point(), player.dig_radius*strength, player.dig_strength)
		var instantiated_mining_particles: Node3D = player.mining_particles.instantiate()
		get_tree().root.add_child(instantiated_mining_particles)
		instantiated_mining_particles.global_position = player.looking_at_ray.get_collision_point()
