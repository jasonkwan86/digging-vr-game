# TerrainNoiseModifier.gd
# Attach this to any node in the scene. 
# Run it AFTER ModifiableGround._ready() has finished.

@tool
class_name NoiseModifier
extends Node

@export var ground: ModifiableGround

@export_group("Noise Settings")
@export var noise: FastNoiseLite
@export var noise_strength: float = 6.0   # How many voxel layers deep the noise carves
@export var apply: bool:
	set(_v):
		print("generating with noise modifier")
		ground.generate()
		apply_noise()

func _ready() -> void:
	await get_tree().process_frame
	apply_noise()

func apply_noise() -> void:
	if ground == null or ground.voxel_grid == null:
		push_warning("TerrainNoiseModifier: ground or voxel_grid is null")
		return

	var grid = ground.voxel_grid
	var width = grid.width
	var height = grid.height

	# Find the top surface row (y = height-1 is open air in the original script)
	# Walk down from the top and subtract based on noise
	for x in range(width):
		for z in range(width):
			var n = noise.get_noise_2d(x, z)  # -1.0 to 1.0
			# Map noise to a positive depth value
			var depth = int((n + 1.0) * 0.5 * noise_strength)  # 0 to noise_strength

			# Carve from the top surface downward by 'depth' voxels
			# y = 0 and y = height-1 stay at default (solid / air boundary)
			for y in range(height - 1, max(0, height - 1 - depth), -1):
				grid.add(x, y, z, 1.0)

	ground.regenerate()
