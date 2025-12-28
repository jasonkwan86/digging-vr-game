class_name MoneyAndUpgrades
extends Node

var money: int:
	set(value):
		money = value
		money_count_label.text = str(money)

@export var money_count_label: Label

func add_money(money_to_add: int) -> void:
	money += money_to_add
