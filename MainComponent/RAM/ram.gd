extends Node2D

@export var max_capacity: float = 200
@export var segmentation: String

func Add_Capacity(value: float) -> void:
	max_capacity += value
