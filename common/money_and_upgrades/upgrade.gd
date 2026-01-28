class_name Upgrade
extends Resource

var upgrade_name: String
var cost: int
var next_upgrade: Upgrade
var effect

func build(name: String, c: int, next: Upgrade) -> void:
	upgrade_name = name
	cost = c
	next_upgrade = next
