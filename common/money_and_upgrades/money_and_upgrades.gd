class_name MoneyAndUpgrades
extends Node

@export var money_count_label: Label
@export var tool_label: Label
@export var consumable_count_label: Label
@export var merchants: Array[MerchantHandler]
@export var tools: Array[Tool]

var money: int:
	set(value):
		money = value
		money_count_label.text = str(money)
var current_tool = 0

var consumables = {"Rope":0, "Rockets":0, "Bombs":0, "Haste Potions":0, "Greed Potions":0}
var sell_value = 1


func add_money(money_to_add: int) -> void:
	if money_to_add > 0:
		money += (money_to_add*sell_value)
	else:
		money += money_to_add


func unlock_merchant(merchant_id: int) -> void:
	merchants[merchant_id-1].set_visibility(true)


func next_tool(direction: int) -> void:
	current_tool += direction
	if current_tool < 0:
		current_tool = tools.size()-1
	if current_tool >= tools.size():
		current_tool = 0
	if not tools[current_tool].is_unlocked:
		next_tool(direction)
	
	tool_label.text = tools[current_tool].tool_name


func add_consumable(consumable: String, count: int) -> void:
	consumable_count_label.text = ""
	consumables[consumable] += count
	for key in consumables:
		consumable_count_label.text += key + ": " + str(consumables[key]) + "\n"
