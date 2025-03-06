extends "res://MainComponent/RAM/ram.gd"

@export var segmentation_size: float = 5
@export var segmentation_quantity: int = max_capacity / segmentation_size

func _ready() -> void:
	segmentation = "fixo"
	Update_Size()

func Update_Segmentation_Quantity():
	segmentation_quantity = max_capacity / segmentation_size

func Change_Segmentation_Size(value: float):
	segmentation_size = value
	Update_Segmentation_Quantity()

func Add_Capacity(value: float):
	max_capacity += value
	Update_Size()
	Update_Segmentation_Quantity()
