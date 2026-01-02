extends CharacterBody3D

# TODO: Separate this out into PlayerMovementController and PlayerCameraController scripts and components

@export_group("Player Controls")
@export var camera: Camera3D
@export var mouse_sensitivity = 0.002
@export var interact_icon: Control

@export_group("Voxel Interactions")
@export var dig_reach: float = 3
@export var dig_radius: int = 1
@export var dig_strength: float = 1
@export var looking_at_ray: RayCast3D
@export var looking_at_shapecast: ShapeCast3D

@export var item_pickup_sound_player: AudioStreamPlayer
@export var mineral_sell_player: AudioStreamPlayer

@export_group("Inventory and Upgrades")
@export var mineral_inventory: MineralInventory
@export var money_and_upgrades: MoneyAndUpgrades

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	var dig_reach_position: Vector3 = dig_reach * Vector3.FORWARD
	looking_at_ray.target_position = dig_reach_position
	looking_at_shapecast.target_position = dig_reach_position

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("dig"):
		var looking_at_object = looking_at_ray.get_collider()
		if looking_at_object is ModifiableGround:
			looking_at_object.remove_from(looking_at_ray.get_collision_point(), dig_radius, dig_strength)
	
	if Input.is_action_just_pressed("pickup_mineral"):
		var looking_at_object = looking_at_ray.get_collider()
		if looking_at_object is Mineral:
			looking_at_object.queue_free()
			mineral_inventory.add_mineral_to_inventory(looking_at_object)
			item_pickup_sound_player.play()
		if looking_at_object is SellStation:
			money_and_upgrades.add_money(mineral_inventory.sum_mineral_sell_values())
			mineral_inventory.sell_all_minerals()
			mineral_sell_player.play()

func _process(_delta: float) -> void:
	var looking_at_object = looking_at_ray.get_collider()
	if looking_at_object is Mineral:
		(looking_at_object as Mineral).mineral_being_looked_at()
	interact_icon.visible = looking_at_object is Mineral
