class_name MineralOnPickupStrategy
extends BuriedItemOnPickupStrategy

@export var mineral_name: String
@export var sell_value: int = 5

func execute(_player: Player):
	_player.mineral_inventory.add_mineral_to_inventory(self)
	AudioManager.play_item_grab_sound()
