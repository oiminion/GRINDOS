extends "res://MainComponent/RAM/ram.gd"

@export var segmentation_size: float = 5
@export var segmentation_quantity: int = max_capacity / segmentation_size

signal Module_Selected(module: Module)
signal Clear_CPU_Connected
signal Clear_Data_Connected
signal Clear_Apps_Connected

var processes: Array

var process_scene: PackedScene = preload("res://Auxiliar/process.tscn")

func Calculate_Module_Size() -> float:
	return $memory_space.scale.y / max_capacity * segmentation_size

func Update_Segmentation_Quantity() -> void:
	segmentation_quantity = max_capacity / segmentation_size

func Change_Segmentation_Size(value: float) -> void:
	segmentation_size = value
	Update_Segmentation_Quantity()

func Add_Capacity(value: float) -> void:
	max_capacity += value
	Update_Segmentation_Quantity()

func Clear_Selected_Process() -> void:
	Clear_CPU_Connected.emit()

func Initialize_Ram() -> void:
	var off_set: int = Calculate_Module_Size() * 196
	for i in segmentation_quantity:
		var instance = process_scene.instantiate()
		add_child(instance)
		self.Clear_CPU_Connected.connect(instance.Clear_CPU_Connected)
		self.Clear_Data_Connected.connect(instance.Clear_Data_Connected)
		self.Clear_Apps_Connected.connect(instance.Clear_Apps_Connected)
		instance.scale.y = Calculate_Module_Size()
		instance.position.x = 32
		if i == 0:
			instance.position.y = instance.scale.y * 32 + 1
		else:
			instance.position.y = instance.scale.y * 32 + off_set + 1
		off_set = instance.position.y + instance.scale.y * 32

func _ready() -> void:
	segmentation = "fixo"
	Initialize_Ram()

func Process_Selected(module: Module) -> void:
	Module_Selected.emit(module)
