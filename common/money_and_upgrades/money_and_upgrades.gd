class_name MoneyAndUpgrades
extends Node

@export var money_count_label: Label
@export var tool_label: Label
@export var consumable_count_label: RichTextLabel

var money: int:
	set(value):
		money = value
		money_count_label.text = str(money)

var tools: Array[Node]
var current_tool = 0

var consumables: Array[Node]
var current_consumable = 0

var sell_value = 1

func _ready() -> void:
	tools = $Tools.get_children()
	consumables = $Consumables.get_children()
	update_consumable_label()


func add_money(money_to_add: int) -> void:
	if money_to_add > 0:
		money += (money_to_add*sell_value)
	else:
		money += money_to_add


func next_tool(direction: int) -> void:
	current_tool += direction
	if current_tool < 0:
		current_tool = tools.size()-1
	if current_tool >= tools.size():
		current_tool = 0
	if not tools[current_tool].is_unlocked:
		next_tool(direction)
	
	tool_label.text = tools[current_tool].tool_name


func next_consumable(direction: int) -> void:
	current_consumable += direction
	if current_consumable < 0:
		current_consumable = consumables.size()-1
	if current_consumable >= consumables.size():
		current_consumable = 0
	if not consumables[current_consumable].usable:
		next_consumable(direction)
	else:
		update_consumable_label()


func update_consumable_label() -> void:
	consumable_count_label.text = ""
	for i in range(consumables.size()):
		var consumable = consumables[i]
		if not consumable.usable:
			consumable_count_label.append_text("\n")
		if i == current_consumable:
			consumable_count_label.append_text("[color=green]")
		consumable_count_label.append_text(consumable.consumable_name + ": " + str(consumable.count) + "\n")
		if i == current_consumable:
			consumable_count_label.append_text("[/color]")
