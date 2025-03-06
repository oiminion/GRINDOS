extends StaticBody2D

class_name Module

signal button_pressed(module: Module)

func _on_button_button_up() -> void:
	button_pressed.emit(self)
