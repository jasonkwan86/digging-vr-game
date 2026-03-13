class_name UnlockTool
extends Upgrade

@export var tool_to_unlock: Node

func buy_upgrade() -> void:
	tool_to_unlock.is_unlocked = true
