extends Node2D

@export var Selected: Module = null


func _on_so_tutorial_so_selected(module: Module) -> void:
	Selected = module
