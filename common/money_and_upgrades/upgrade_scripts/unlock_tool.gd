class_name UnlockTool
extends Upgrade

@export var tool_to_unlock: Tool

func _init() -> void:
	is_repeating = false

func do_upgrade(_player: Player) -> void:
	tool_to_unlock.is_unlocked = true
