extends Node2D

@export var max_capacity: float = 20
@export var segmentation: String

func Update_Size() -> void:
	$memory_space.scale.y = max_capacity / 5
	$memory_space.position.y = 32 * $memory_space.scale.y

func Add_Capacity(value: float) -> void:
	max_capacity += value
	Update_Size()

func _ready() -> void:
	Update_Size()
