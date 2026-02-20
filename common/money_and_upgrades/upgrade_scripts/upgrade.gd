@abstract class_name Upgrade
extends Resource

@export var upgrade_name: String
@export var cost: int

var is_repeating: bool

@abstract func do_upgrade(player: Player) -> void
