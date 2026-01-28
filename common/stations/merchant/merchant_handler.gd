class_name MerchantHandler
extends Node

@export var merchant_id: int

func _ready() -> void:
	if merchant_id > 0:
		set_visibility(false)

func set_visibility(vis: bool) -> void:
	for child in get_children():
		if child is CanvasItem or child is Node3D:
			child.visible = vis
	self.process_mode = Node.PROCESS_MODE_INHERIT if vis else Node.PROCESS_MODE_DISABLED
