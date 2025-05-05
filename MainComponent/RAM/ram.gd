extends Node2D

@export var segmentation: String

func Add_Capacity(value: float) -> void:
	Global.RAM_max_capacity += value
