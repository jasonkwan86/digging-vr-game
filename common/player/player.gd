class_name Player
extends CharacterBody3D

@export_group("Player Controls")
@export var interact_icon: Control

@export_group("Voxel Interactions")
@export var dig_reach: float = 3
@export var dig_radius: float = 1
@export var dig_strength: float = 1
@export var dig_speed: float = 1
@export var bag_size = 5
@export var looking_at_ray: RayCast3D
@export var looking_at_shapecast: ShapeCast3D
@export var mining_particles: PackedScene

@export_group("Inventory and Upgrades")
@export var mineral_inventory: MineralInventory
@export var money_and_upgrades: MoneyAndUpgrades

var dig_cooldown: float = 0


func _ready() -> void:
	create_look_ray()


func create_look_ray() -> void:
	var dig_reach_position: Vector3 = dig_reach * Vector3.FORWARD
	looking_at_ray.target_position = dig_reach_position
	looking_at_shapecast.target_position = dig_reach_position


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("dig"):
		if money_and_upgrades.current_tool == 0:
			dig(0.75)
		elif money_and_upgrades.current_tool == 1:
			dig(1)
		elif money_and_upgrades.current_tool == 3:
			shoot()
	
	if Input.is_action_pressed("dig") and money_and_upgrades.current_tool == 2 and dig_cooldown <= 0:
		dig(1)
		dig_cooldown = 1/dig_speed
		
	if dig_cooldown > 0:
		dig_cooldown -= delta
		
	if Input.is_action_just_pressed("interact"):
		# Could be buried item, sell/upgrade station or other
		var looking_at_object = looking_at_ray.get_collider()
		if looking_at_object != null and looking_at_object.has_method("interact"):
			looking_at_object.interact(self)
			
	if Input.is_action_just_pressed("cycle_tool_left"):
		money_and_upgrades.next_tool(-1)
	
	if Input.is_action_just_pressed("cycle_tool_right"):
		money_and_upgrades.next_tool(1)


func _process(_delta: float) -> void:
	var looking_at_object = looking_at_ray.get_collider()
	if looking_at_object is BuriedItem:
		(looking_at_object as BuriedItem).mineral_being_looked_at()
	interact_icon.visible = (looking_at_object is BuriedItem or looking_at_object is SellStation or looking_at_object is ShopItem)


func dig(size_mod: float) -> void:
	var looking_at_object = looking_at_ray.get_collider()
	if looking_at_object is ModifiableGround:
		looking_at_object.remove_from(looking_at_ray.get_collision_point(), dig_radius*size_mod, dig_strength)
		var instantiated_mining_particles: Node3D = mining_particles.instantiate()
		get_tree().root.add_child(instantiated_mining_particles)
		instantiated_mining_particles.global_position = looking_at_ray.get_collision_point()


func shoot() -> void:
	pass # create and launch the rocket


func do_upgrade(upgrade: Upgrade) -> void:
	match upgrade.effect_type:
		"unlock_tool":
			money_and_upgrades.unlock_tool(int(upgrade.effect_value))
		"unlock_merchant":
			money_and_upgrades.unlock_merchant(int(upgrade.effect_value))
		"dig_speed":
			dig_speed += upgrade.effect_value
		"dig_radius":
			dig_radius += upgrade.effect_value
		"dig_reach":
			dig_reach += upgrade.effect_value
			create_look_ray()
		"bag_size":
			bag_size += int(upgrade.effect_value)
		"sell_value":
			money_and_upgrades.sell_value += upgrade.effect_value
		"speed":
			$PlayerCameraAndMovementController.speed += upgrade.effect_value
		"jump_velocity":
			$PlayerCameraAndMovementController.jump_velocity += upgrade.effect_value
		"add_consumable":
			money_and_upgrades.add_consumable(upgrade.consumable_id, int(upgrade.effect_value))
		_:
			print("Unknown effect")
