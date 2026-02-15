class_name MoneyAndUpgrades
extends Node

var money: int:
	set(value):
		money = value
		money_count_label.text = str(money)

@export var money_count_label: Label
@export var tool_label: Label
@export var consumable_count_label: Label
@export var merchants: Array[MerchantHandler]

var tool_index = ["Hands", "Pickaxe", "Drill", "Rocket Launcher"]
var unlocked_tools = 0
var current_tool = 0

# Rope, Rocket, Bomb, Haste Pot, Greed Pot
var consumables = [0, 0, 0, 0, 0]
var sell_value = 1

var initial_upgrades = []
var merchant_index = ["Blacksmith", "Demolitionist", "Wizard"]

func add_money(money_to_add: int) -> void:
	if money_to_add > 0:
		money += (money_to_add*sell_value)
	else:
		money += money_to_add

func unlock_merchant(merchant_id: int) -> void:
	merchants[merchant_id-1].set_visibility(true)
	
func unlock_tool(player: Player, tool_id: int) -> void:
	player.money_and_upgrades.unlocked_tools = tool_id
	current_tool = tool_id
	next_tool(0)
	
func next_tool(direction: int) -> void:
	current_tool += direction
	if current_tool < 0:
		current_tool = unlocked_tools
	if current_tool > unlocked_tools:
		current_tool = 0
	
	tool_label.text = tool_index[current_tool]

func add_consumable(consumable_id: int, count: int) -> void:
	consumables[consumable_id] += count
	consumable_count_label.text = "Rope: " + str(consumables[0]) + "\nRockets: " + str(consumables[1]) + "\nBombs: " + str(consumables[2]) + "\nHaste Potions: " + str(consumables[3]) + "\nGreed Potions: " + str(consumables[4])

func _ready() -> void:
	
	# Array for first upgrade in each merchant slot
	for i in 3:
		initial_upgrades.append([])
		for j in 3:
			initial_upgrades[i].append(0)
	
	# Blacksmith Slot 1 (Tool)
	var upgrade = Upgrade.new()
	upgrade.build("Demolitionist License", 1, null)
	upgrade.effect = func(player: Player): player.money_and_upgrades.unlock_merchant(1)
	var prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Tool Speed II", 1, prev)
	upgrade.effect = func(player: Player): player.dig_speed += 0.5
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Dig Size III", 1, prev)
	upgrade.effect = func(player: Player): player.dig_radius += 0.25
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Longer Reach II", 1, prev)
	upgrade.effect = func(player: Player):
		player.dig_reach += 0.5
		player.create_look_ray()
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Tool Speed I", 1, prev)
	upgrade.effect = func(player: Player): player.dig_speed += 0.5
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("New Tool: Drill", 1, prev)
	upgrade.effect = func(player: Player): unlock_tool(player, 2)
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Dig Size II", 1, prev)
	upgrade.effect = func(player: Player): player.dig_radius += 0.25
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Longer Reach I", 1, prev)
	upgrade.effect = func(player: Player):
		player.dig_reach += 0.5
		player.create_look_ray()
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Dig Size I", 1, prev)
	upgrade.effect = func(player: Player): player.dig_radius += 0.25
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("New Tool: Pickaxe", 1, prev)
	upgrade.effect = func(player: Player): unlock_tool(player, 1)
	initial_upgrades[0][0] = upgrade
	
	# Blacksmith Slot 2 (Utility)
	
	upgrade = Upgrade.new()
	upgrade.build("Sell Value II", 1, null)
	upgrade.effect = func(player: Player): player.money_and_upgrades.sell_value += 0.25 
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Bag Size III", 1, prev)
	upgrade.effect = func(player: Player): player.bag_size += 5
	prev = upgrade
	
	#upgrade = Upgrade.new()
	#upgrade.build("Extra Pocket", 1, prev)
	#upgrade.effect = func(_player: Player): print("Extra Pocket")
	#prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Sell Value I", 1, prev)
	upgrade.effect = func(player: Player): player.money_and_upgrades.sell_value += 0.25 
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Bag Size II", 1, prev)
	upgrade.effect = func(player: Player): player.bag_size += 5
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Lightweight I", 1, prev)
	upgrade.effect = func(player: Player):
		player.speed += 2
		player.jump_velocity += 1.5
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Bag Size I", 1, prev)
	upgrade.effect = func(player: Player): player.bag_size += 5
	initial_upgrades[0][1] = upgrade
	
	# Blacksmith Slot 3 (Rope)
	upgrade = Upgrade.new()
	upgrade.build("Rope", 1, upgrade)
	upgrade.effect = func(player: Player): player.money_and_upgrades.add_consumable(0,1)
	initial_upgrades[0][2] = upgrade
	
	# Demolitionist Slot 1 (Tool)
	upgrade = Upgrade.new()
	upgrade.build("Wizard License", 1, null)
	upgrade.effect = func(player: Player): player.money_and_upgrades.unlock_merchant(2)
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Dig Size VI", 1, prev)
	upgrade.effect = func(player: Player): player.dig_radius += 0.25 
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Tool Speed V", 1, prev)
	upgrade.effect = func(player: Player): player.dig_speed += 0.5
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Dig Size V", 1, prev)
	upgrade.effect = func(player: Player): player.dig_radius += 0.5
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("New Tool: Rocket Launcher", 1, prev)
	upgrade.effect = func(player: Player): unlock_tool(player, 3)
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Tool Speed IV", 1, prev)
	upgrade.effect = func(player: Player): player.dig_speed += 0.5
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Longer Reach III", 1, prev)
	upgrade.effect = func(player: Player):
		player.dig_reach += 0.5
		player.create_look_ray()
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Dig Size IV", 1, prev)
	upgrade.effect = func(player: Player): player.dig_radius += 0.25
	prev = upgrade
	
	upgrade = Upgrade.new()
	upgrade.build("Tool Speed III", 1, prev)
	upgrade.effect = func(player: Player): player.dig_speed += 0.5
	initial_upgrades[1][0] = upgrade
	
	# Demolitionist Slot 2 (Rockets)
	upgrade = Upgrade.new()
	upgrade.build("Rocket", 1, upgrade)
	upgrade.effect = func(player: Player): player.money_and_upgrades.add_consumable(1,1)
	initial_upgrades[1][1] = upgrade
	
	# Demolitionist Slot 3 (Sticky Bombs)
	upgrade = Upgrade.new()
	upgrade.build("Sticky Bomb", 1, upgrade)
	upgrade.effect = func(player: Player): player.money_and_upgrades.add_consumable(2,1)
	initial_upgrades[1][2] = upgrade
	
	# Wizard Slot 1 (Spells)
	upgrade = Upgrade.new()
	upgrade.build("Temp", 0, upgrade)
	upgrade.effect = func(_player: Player): print("Temp")
	initial_upgrades[2][0] = upgrade
	
	# Wizard Slot 2 (Haste Potion)
	upgrade = Upgrade.new()
	upgrade.build("Haste Potion", 1, upgrade)
	upgrade.effect = func(player: Player): player.money_and_upgrades.add_consumable(3,1)
	initial_upgrades[2][1] = upgrade
	
	# Wizard Slot 3 (Greed Potion)
	upgrade = Upgrade.new()
	upgrade.build("Greed Potion", 1, upgrade)
	upgrade.effect = func(player: Player): player.money_and_upgrades.add_consumable(4,1)
	initial_upgrades[2][2] = upgrade
