class_name Tool
extends Node

@export var tool_name: String
@export var dig_strength: float = 1
@export var dig_power: float = 1
@export var is_unlocked: bool = false

var player: Player

func _ready() -> void:
	player = self.find_parent("Player")
