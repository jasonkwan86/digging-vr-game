class_name MerchantHandler
extends Node

@export var merchant_id: int
@export var unlockCost: Dictionary[MineralOnPickupStrategy, int]

var merchant_name: String

func _ready() -> void:
	merchant_name = $Label3D.text
	
	if merchant_id > 0:
		check_sell_requirement(null)


func check_sell_requirement(player: Player) -> void:
	var merchant_text = merchant_name + "\n"
	var cost_met = true
	for mineral in unlockCost:
		if player == null: # Initial call
			cost_met = false
			merchant_text += (mineral.mineral_name.capitalize()+
				": 0/"+str(unlockCost[mineral])+"\n")
		elif not player.mineral_inventory.total_minerals_sold.has(mineral): # Zero Case
			cost_met = false
			merchant_text += (mineral.mineral_name.capitalize()+
				": 0/"+str(unlockCost[mineral])+"\n")
		elif player.mineral_inventory.total_minerals_sold[mineral] < unlockCost[mineral]:
			cost_met = false
			merchant_text += (mineral.mineral_name.capitalize()+": "+
				str(player.mineral_inventory.total_minerals_sold[mineral])+
				"/"+str(unlockCost[mineral])+"\n")
	
	if cost_met:
		$Label3D.text = merchant_name
		set_visibility(true)
	else:
		$Label3D.text = merchant_text
		set_visibility(false)


func set_visibility(vis: bool) -> void:
	for child in get_children():
		if child is ShopItem:# or child is Label3D:
			child.visible = vis
		if child is CollisionShape3D:
			child.disabled = !vis
	
	var mat = $MeshInstance3D.get_surface_override_material(0).duplicate()
	mat.albedo_color.a = 1.0 if vis else 0.5
	$MeshInstance3D.set_surface_override_material(0,mat)
