extends Node

@export var item_pickup_player: AudioStreamPlayer
@export var mineral_sell_player: AudioStreamPlayer

func play_item_grab_sound() -> void:
	item_pickup_player.play()

func play_mineral_sell_sound() -> void:
	mineral_sell_player.play()
