class_name UnlockLight
extends Upgrade

@export var headlamp: Headlamp

func buy_upgrade() -> void:
	headlamp.set_state(true)
