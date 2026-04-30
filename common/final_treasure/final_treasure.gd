class_name FinalTreasure
extends Node3D

@export var game_over_menu: GameOverMenu

func interact(_player: Player) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	game_over_menu.show()
