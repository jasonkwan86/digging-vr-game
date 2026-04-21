class_name MerchantHandler
extends Node

@export var merchant_id: int

func _ready() -> void:
	if merchant_id > 0:
		set_visibility(false)


func set_visibility(vis: bool) -> void:
	for child in get_children():
		if child is ShopItem or child is Label3D:
			child.visible = vis
		if child is CollisionShape3D:
			child.disabled = !vis
	
	var mat = $MeshInstance3D.get_surface_override_material(0).duplicate()
	mat.albedo_color.a = 1.0 if vis else 0.5
	$MeshInstance3D.set_surface_override_material(0,mat)
