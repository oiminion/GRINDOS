extends Node2D

@export var segmentation: String

func Add_Capacity(value: float) -> void:
	Global.max_capacity += value
