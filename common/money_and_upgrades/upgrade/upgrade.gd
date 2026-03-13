class_name Upgrade
extends Node

@export var upgrade_name: String
@export var cost: int

var is_repeating: bool = false
var player: Player

func _ready() -> void:
	player = self.find_parent("Player")
