class_name DefaultTool
extends Tool

func check_input(_delta: float) -> void:
	if Input.is_action_just_pressed("dig"):
		use_tool()


func use_tool() -> void:
	var looking_at_object = player.looking_at_ray.get_collider()
	if looking_at_object is ModifiableGround:
		looking_at_object.try_remove_from(dig_power, player.looking_at_ray.get_collision_point(), player.dig_radius, dig_strength)
