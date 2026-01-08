class_name MoneyWadOnPickupStrategy
extends BuriedItemOnPickupStrategy

@export var monetary_value: int = 5

func execute(_player: Player) -> void:
	AudioManager.play_item_grab_sound()
	_player.money_and_upgrades.add_money(monetary_value)
