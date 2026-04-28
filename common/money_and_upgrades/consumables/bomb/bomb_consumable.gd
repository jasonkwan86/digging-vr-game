class_name BombConsumable
extends Consumable

@export var bomb_projectile: PackedScene
@export var dig_strength: float
@export var dig_power: float

func _ready() -> void:
	super._ready()
	consumable_name = "Bombs"


func use_item() -> void:
	var direction = -player.get_node("Camera3D").global_transform.basis.z
	
	var bomb: Node3D = bomb_projectile.instantiate()
	get_tree().root.add_child(bomb)
	bomb.configure(dig_power, player.dig_radius, dig_strength, direction, player.global_position)
	
	player.money_and_upgrades.update_consumable_label()
