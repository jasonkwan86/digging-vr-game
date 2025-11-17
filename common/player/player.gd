extends CharacterBody3D

# TODO: Separate this out into PlayerMovementController and PlayerCameraController scripts and components

@export_group("Player Controls")
@export var camera: Camera3D
@export var mouse_sensitivity = 0.002
@export var looking_at_ray: RayCast3D

@export_group("Voxel Interactions")
#@export var voxel_terrain: VoxelTerrain
#@onready var voxel_tool: VoxelTool = voxel_terrain.get_voxel_tool()
@export var modifiable_mesh: ModifiableMesh

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

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
		#print("pressed dig")
		#voxel_tool.mode = VoxelTool.MODE_REMOVE
		#voxel_tool.do_sphere(looking_at_ray.get_collision_point(), 0.75)
		modifiable_mesh.remove_from(looking_at_ray.get_collision_point(), 4)
