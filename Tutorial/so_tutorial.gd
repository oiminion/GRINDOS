extends "res://Auxiliar/module.gd"

signal SO_Selected(module: Module)


func _on_button_button_down() -> void:
	SO_Selected.emit(self)
