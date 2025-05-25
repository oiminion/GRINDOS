extends "res://Auxiliar/module.gd"

class_name Context

@export var context_color: Color

func changeColor(newColor: Color) -> void:
	context_color = newColor
	$Background.self_modulate = context_color
	$Background.visible = true

func clearColor() -> void:
	context_color = Color.WHITE
	$Background.self_modulate = Color.WHITE
	$Background.visible = false

func _ready():
	self.button_pressed.connect(get_parent().Context_Module_Selected)
	context_color = Color.WHITE
