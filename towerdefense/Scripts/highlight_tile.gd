extends Node2D
class_name HighlightTile

func _process(delta: float) -> void:
	follow_mouse_position()

func follow_mouse_position() -> void:
	var mouse_position : Vector2i = get_global_mouse_position() / 16
	position = mouse_position * 16
