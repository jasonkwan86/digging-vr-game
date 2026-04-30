class_name GameOverMenu
extends Control

func _ready() -> void:
	hide()

func _on_button_button_down() -> void:
	get_tree().reload_current_scene()
