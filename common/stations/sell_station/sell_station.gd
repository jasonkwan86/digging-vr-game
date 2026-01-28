class_name SellStation
extends Node

func interact(player: Player) -> void:
	player.money_and_upgrades.add_money(player.mineral_inventory.sum_mineral_sell_values())
	player.mineral_inventory.sell_all_minerals()
	player.mineral_inventory.change_label_colour(Color.WHITE)
	AudioManager.play_mineral_sell_sound()
