class_name RocketLauncher
extends Tool

const ROCKET_COOLDOWN_MOD: int = 2

@export var rocket_projectile: PackedScene
@export var rocket_consumable: RocketConsumable

var dig_cooldown: float = 0

func check_input(delta: float) -> void:
	if Input.is_action_just_pressed("dig") and dig_cooldown <= 0:
		use_tool()
		dig_cooldown = ROCKET_COOLDOWN_MOD/player.dig_speed
	
	if dig_cooldown > 0:
		dig_cooldown -= delta

func use_tool() -> void:
	if rocket_consumable.count <= 0:
		return
	
	rocket_consumable.add(-1)
	player.money_and_upgrades.update_consumable_label()
	
	var direction = -player.get_node("Camera3D").global_transform.basis.z
	
	var rocket: Node3D = rocket_projectile.instantiate()
	get_tree().root.add_child(rocket)
	rocket.configure(player.dig_radius, player.dig_strength, player.dig_reach, direction, player.global_position)
