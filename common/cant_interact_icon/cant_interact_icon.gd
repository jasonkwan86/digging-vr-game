@tool
class_name CantInteractIcon
extends Control

@export var description: Label

@export var line_color: Color = Color.RED:
	set(value):
		line_color = value
		queue_redraw()

@export var line_thickness: float = 10.0:
	set(value):
		line_thickness = value
		queue_redraw()

func _ready() -> void:
	visible = false

## Show icon with custom description.
func show_cant_interact_icon(description_text: String) -> void:
	visible = true
	description.text = description_text

func hide_cant_interact_icon() -> void:
	visible = false

func _draw():
	var s: Vector2 = size
	
	# Top-left (0,0), bottom-right (s.x, s.y)
	# For opposite diagonal, use: draw_line(Vector2(s.x, 0), Vector2(0, s.y), ...)
	draw_line(Vector2(s.x, 0), Vector2(0, s.y), line_color, line_thickness, true)
