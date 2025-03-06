extends Node2D

@export var max_capacity: float = 15
@export var segmentation: String

func Update_Size():
	$Background.scale.y = max_capacity / 5
	$Background.position.y = 32 * $Background.scale.y

func Add_Capacity(value: float):
	max_capacity += value
	Update_Size()

func _ready() -> void:
	Update_Size()
