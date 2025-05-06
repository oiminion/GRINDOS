extends StaticBody2D

class_name Context

signal button_pressed(context: Context)

@export var context_color: Color

func changeColor(newColor: Color) -> void:
	context_color = newColor
	self_modulate = context_color
	$Background.visible = true

func clearColor() -> void:
	context_color = Color.WHITE
	self_modulate = Color.WHITE
	$Background.visible = false

func contextSelected() -> void:
	button_pressed.emit(self)
