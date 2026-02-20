class_name Player
extends CharacterBody3D

const ROCKET_SPEED: int = 8
const ROCKET_RANGE_MOD: int = 4
const ROCKET_COOLDOWN_MOD: int = 2

const STARTING_POSITION: Vector3 = Vector3(9,1,2)

@export_group("Player Controls")
@export var interact_icon: Control
@export var camera_and_movement_controller: PlayerCameraAndMovementController

@export_group("Voxel Interactions")
@export var dig_reach: float = 3
@export var dig_radius: float = 1
@export var dig_strength: float = 1
@export var dig_speed: float = 1
@export var bag_size: int = 5
@export var potion_duration: int = 30
@export var looking_at_ray: RayCast3D
@export var looking_at_shapecast: ShapeCast3D
@export var mining_particles: PackedScene
@export var rocket_projectile: PackedScene

@export_group("Inventory and Upgrades")
@export var mineral_inventory: MineralInventory
@export var money_and_upgrades: MoneyAndUpgrades

@export_group("")
@export var potion_label: Label

var dig_cooldown: float = 0
var haste_time: float = 0
var greed_time: float = 0


func _ready() -> void:
	create_look_ray()


func create_look_ray() -> void:
	var dig_reach_position: Vector3 = dig_reach * Vector3.FORWARD
	looking_at_ray.target_position = dig_reach_position
	looking_at_shapecast.target_position = dig_reach_position


func _physics_process(delta: float) -> void:
	var tool = money_and_upgrades.tools[money_and_upgrades.current_tool]
	if Input.is_action_just_pressed("dig") and not tool.is_auto:
		if tool.is_projectile:
			if dig_cooldown <= 0:
				shoot()
				dig_cooldown = ROCKET_COOLDOWN_MOD/dig_speed
		else:
			dig(tool.strength)
	
	if Input.is_action_pressed("dig") and tool.is_auto and dig_cooldown <= 0:
		dig(tool.strength)
		dig_cooldown = 1/dig_speed
		
	if dig_cooldown > 0:
		dig_cooldown -= delta
	
	potion_label.text = ""
	if haste_time > 0:
		haste_time -= delta
		potion_label.text += "Haste: %0.2f\n" % haste_time
	
	if greed_time > 0:
		greed_time -= delta
		potion_label.text += "Greed: %0.2f" % greed_time
		
	if Input.is_action_just_pressed("interact"):
		# Could be buried item, sell/upgrade station or other
		var looking_at_object = looking_at_ray.get_collider()
		if looking_at_object != null and looking_at_object.has_method("interact"):
			looking_at_object.interact(self)
			
	if Input.is_action_just_pressed("cycle_tool_left"):
		money_and_upgrades.next_tool(-1)
	
	if Input.is_action_just_pressed("cycle_tool_right"):
		money_and_upgrades.next_tool(1)
	
	if Input.is_action_just_pressed("use_rope"):
		use_rope()
	
	if Input.is_action_just_pressed("use_bomb"):
		use_bomb()
	
	if Input.is_action_just_pressed("use_haste"):
		use_haste()
	
	if Input.is_action_just_pressed("use_greed"):
		use_greed()


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
	if money_and_upgrades.consumables["Rockets"] <= 0:
		return
	
	money_and_upgrades.add_consumable("Rockets", -1)
	
	var direction = -$Camera3D.global_transform.basis.z
	
	var rocket: Node3D = rocket_projectile.instantiate()
	get_tree().root.add_child(rocket)
	rocket.configure(ROCKET_SPEED, dig_radius, dig_strength, dig_reach*ROCKET_RANGE_MOD, direction, global_position)

func use_rope() -> void:
	if money_and_upgrades.consumables["Rope"] <= 0:
		return
	
	money_and_upgrades.add_consumable("Rope", -1)
	
	global_position = STARTING_POSITION

func use_bomb() -> void:
	if money_and_upgrades.consumables["Bombs"] <= 0:
		return
	
	money_and_upgrades.add_consumable("Bombs", -1)
	
	print("boom")
	# to be implemented

func use_haste() -> void:
	if money_and_upgrades.consumables["Haste Potions"] <= 0:
		return
	
	money_and_upgrades.add_consumable("Haste Potions", -1)
	
	haste_time = potion_duration

func use_greed() -> void:
	if money_and_upgrades.consumables["Greed Potions"] <= 0:
		return
	
	money_and_upgrades.add_consumable("Greed Potions", -1)
	
	greed_time = potion_duration
	# to be implemented
