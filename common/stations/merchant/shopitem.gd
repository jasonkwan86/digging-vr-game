class_name ShopItem
extends Node

@export var slot_id: int = 0
@export var player: Player
@export var current_item: Upgrade

var merchant_id: int = 0

func _ready() -> void:
	merchant_id = get_parent().merchant_id
	update_label()


func interact(player: Player) -> void:
	if player.money_and_upgrades.money >= current_item.cost:
		AudioManager.play_mineral_sell_sound()
		player.money_and_upgrades.add_money(-1*current_item.cost)
		player.do_upgrade(current_item)
		if current_item.consumable_id < 0:
			current_item = current_item.next_upgrade
		if current_item == null:
			hide_item()
		else:
			update_label()
	else:
		AudioManager.play_item_grab_sound()


func update_label() -> void:
	$ShopItemLabel.text = current_item.upgrade_name + " ($" + str(current_item.cost) + ")"


func hide_item() -> void:
	$ShopItemBox.disabled = true
	for child in get_children():
		if child is CanvasItem or child is Node3D:
			child.visible = false
