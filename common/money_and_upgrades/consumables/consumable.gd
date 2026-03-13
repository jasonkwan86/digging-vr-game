class_name Consumable
extends Node

var consumable_name: String
var count: int = 0
var usable: bool = true
var player: Player

func _ready() -> void:
	player = self.find_parent("Player")


func add(amount: int) -> void:
	count += amount
	player.money_and_upgrades.update_consumable_label()


func check_input() -> void:
	if Input.is_action_just_pressed("use_consumable") and count > 0:
		count -= 1
		use_item()


func use_item() -> void:
	pass
