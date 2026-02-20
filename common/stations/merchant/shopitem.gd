class_name ShopItem
extends Node

@export var slot_id: int = 0
@export var player: Player
@export var items: Array[Upgrade]

var current_item: int = 0
var merchant_id: int = 0

func _ready() -> void:
	merchant_id = get_parent().merchant_id
	update_label()


func interact(player: Player) -> void:
	if player.money_and_upgrades.money >= items[current_item].cost:
		AudioManager.play_mineral_sell_sound()
		player.money_and_upgrades.add_money(-1*items[current_item].cost)
		items[current_item].do_upgrade(player)
		if not items[current_item].is_repeating:
			current_item += 1
		if current_item >= items.size():
			hide_item()
		else:
			update_label()
	else:
		AudioManager.play_item_grab_sound()


func update_label() -> void:
	$ShopItemLabel.text = items[current_item].upgrade_name + " ($" + str(items[current_item].cost) + ")"


func hide_item() -> void:
	$ShopItemBox.disabled = true
	for child in get_children():
		if child is CanvasItem or child is Node3D:
			child.visible = false
