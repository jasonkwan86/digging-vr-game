class_name SellStation
extends Node

@export var demolitionist: MerchantHandler
@export var wizard: MerchantHandler

func interact(player: Player) -> void:
	player.money_and_upgrades.add_money(player.mineral_inventory.sum_mineral_sell_values())
	
	if player.mineral_inventory.has_minerals():
		AudioManager.play_mineral_sell_sound()
		player.mineral_inventory.sell_all_minerals()
	player.mineral_inventory.change_label_colour(Color.WHITE)
	update_labels(player)


func update_labels(player: Player) -> void:
	var sellCountText = "Sell Count:\n"
	for mineral in player.mineral_inventory.total_minerals_sold:
		sellCountText += (mineral.mineral_name.capitalize() + ": " + 
			str(player.mineral_inventory.total_minerals_sold[mineral]) + "\n")
	$SellCount.text = sellCountText
	
	demolitionist.check_sell_requirement(player)
	wizard.check_sell_requirement(player)
