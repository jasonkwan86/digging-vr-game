class_name MoneyAndUpgrades
extends Node

const TOOL_NAME_INDEX = ["Hands", "Pickaxe", "Drill", "Rocket Launcher"]

@export var money_count_label: Label
@export var tool_label: Label
@export var consumable_count_label: Label
@export var merchants: Array[MerchantHandler]

var money: int:
	set(value):
		money = value
		money_count_label.text = str(money)
var unlocked_tools = 0
var current_tool = 0

# Rope, Rocket, Bomb, Haste Pot, Greed Pot
var consumables = [0, 0, 0, 0, 0]
var sell_value = 1


func add_money(money_to_add: int) -> void:
	if money_to_add > 0:
		money += (money_to_add*sell_value)
	else:
		money += money_to_add


func unlock_merchant(merchant_id: int) -> void:
	merchants[merchant_id-1].set_visibility(true)


func unlock_tool(tool_id: int) -> void:
	unlocked_tools = tool_id
	current_tool = tool_id
	next_tool(0)


func next_tool(direction: int) -> void:
	current_tool += direction
	if current_tool < 0:
		current_tool = unlocked_tools
	if current_tool > unlocked_tools:
		current_tool = 0
	
	tool_label.text = TOOL_NAME_INDEX[current_tool]


func add_consumable(consumable_id: int, count: int) -> void:
	consumables[consumable_id] += count
	consumable_count_label.text = "Rope: " + str(consumables[0]) + "\nRockets: " + str(consumables[1]) + "\nBombs: " + str(consumables[2]) + "\nHaste Potions: " + str(consumables[3]) + "\nGreed Potions: " + str(consumables[4])
