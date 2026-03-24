class_name Greed
extends Consumable

@export var greed_label: Label
@export var greed_aura: Area3D

var greed_time: float = 0


func _ready() -> void:
	super._ready()
	consumable_name = "Greed Potions"


func _physics_process(delta: float) -> void:
	if greed_time > 0:
		greed_time -= delta
		greed_label.text = "Greed: %0.2f" % greed_time
		greed_label.visible = true
		greed_aura.monitoring = true
	
	else:
		greed_label.visible = false
		greed_aura.monitoring = false


func use_item() -> void:
	greed_time = player.potion_duration
	player.money_and_upgrades.update_consumable_label()


func _on_greed_range_body_entered(body: Node3D) -> void:
	if body is BuriedItem:
		body.mesh.material_overlay = body.greed_highlight


func _on_greed_range_body_exited(body: Node3D) -> void:
	if body is BuriedItem:
		body.mesh.material_overlay = null
