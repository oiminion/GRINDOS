extends "res://Auxiliar/module.gd"

class_name Context

@export var color: Color
var can_change_CPU_color: bool:
	get:
		return can_change_CPU_color
	set(value):
		can_change_CPU_color = true

func changeColor(newColor: Color) -> void:
	color = newColor
	$Background.self_modulate = color
	$Background.visible = true

func Connect_Apps() -> void:
	pass

func clearColor() -> void:
	color = Color.WHITE
	$Background.self_modulate = Color("3e3e60")
	$Background.visible = false

func _ready():
	self.button_pressed.connect(get_parent().Context_Module_Selected)
	color = Color.WHITE
	can_change_CPU_color = true
