extends "res://Auxiliar/module.gd"

@export var color: Color

func clear_Context() -> void:
	color = Color.WHITE
	$Background.modulate = color

func connect_Context(hex_code: String) -> void:
	color = Color(hex_code)
	$Background.modulate = color

func connect_ContextColor(context_color: Color) -> void:
	color = context_color
	$Background.modulate = color

func _ready() -> void:
	color = Color.WHITE
