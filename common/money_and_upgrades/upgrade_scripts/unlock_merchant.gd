class_name UnlockMerchant
extends Upgrade

@export var merchant_id_to_unlock: int

func _init() -> void:
	is_repeating = false

func do_upgrade(player: Player) -> void:
	player.money_and_upgrades.unlock_merchant(merchant_id_to_unlock)
