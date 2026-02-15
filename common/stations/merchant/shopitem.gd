class_name ShopItem
extends Node

var merchant_id: int = 0
@export var slot_id: int = 0
var current_item: Upgrade
@export var player: Player

func _ready() -> void:
	merchant_id = get_parent().merchant_id
	current_item = player.money_and_upgrades.initial_upgrades[merchant_id][slot_id]
	
	update_label()
	
func interact(player: Player) -> void:
	if player.money_and_upgrades.money >= current_item.cost:
		AudioManager.play_mineral_sell_sound()
		player.money_and_upgrades.add_money(-1*current_item.cost)
		current_item.effect.call(player)
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
