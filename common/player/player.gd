class_name Player
extends CharacterBody3D

@export_group("Player Controls")
@export var interact_icon: Control

@export_group("Voxel Interactions")
@export var dig_reach: float = 3
@export var dig_radius: float = 1
@export var dig_speed: float = 1
@export var bag_size: int = 5
@export var potion_duration: int = 30
@export var looking_at_ray: RayCast3D
@export var looking_at_shapecast: ShapeCast3D
@export var mining_particles: PackedScene

@export_group("Inventory and Upgrades")
@export var mineral_inventory: MineralInventory
@export var money_and_upgrades: MoneyAndUpgrades

func _ready() -> void:
	create_look_ray()


func create_look_ray() -> void:
	var dig_reach_position: Vector3 = dig_reach * Vector3.FORWARD
	looking_at_ray.target_position = dig_reach_position
	looking_at_shapecast.target_position = dig_reach_position


func _physics_process(delta: float) -> void:
	# Poll for tool and consumable input
	money_and_upgrades.tools[money_and_upgrades.current_tool].check_input(delta)
	money_and_upgrades.consumables[money_and_upgrades.current_consumable].check_input()
	
	if Input.is_action_just_pressed("interact"):
		# Could be buried item, sell/upgrade station or other
		var looking_at_object = looking_at_ray.get_collider()
		if looking_at_object != null and looking_at_object.has_method("interact"):
			looking_at_object.interact(self)
	
	if Input.is_action_just_pressed("cycle_tool_left"):
		money_and_upgrades.next_tool(-1)
	
	if Input.is_action_just_pressed("cycle_tool_right"):
		money_and_upgrades.next_tool(1)
	
	if Input.is_action_just_pressed("cycle_consumable_left"):
		money_and_upgrades.next_consumable(-1)
	
	if Input.is_action_just_pressed("cycle_consumable_right"):
		money_and_upgrades.next_consumable(1)


func _process(_delta: float) -> void:
	var looking_at_object = looking_at_ray.get_collider()
	if looking_at_object is BuriedItem:
		(looking_at_object as BuriedItem).mineral_being_looked_at()
	interact_icon.visible = (looking_at_object is BuriedItem or 
							looking_at_object is SellStation or 
							(looking_at_object is ShopItem and looking_at_object.visible))
