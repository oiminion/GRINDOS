extends Node2D

signal Apss_Selected(module: Module)
signal Data_Selected(module: Module)
signal SO_Selected(module: Module)

@export var max_capacity: float = 50

@export var Data: float = 15
@export var Apps: float = 10
@export var So: float = 5

@export var connected: Module = null



func Calculate_Module_Size(value: float) -> float:
	return $Background.scale.y / max_capacity * value

func Update_Ui() -> void:
	$Data.scale.y = Calculate_Module_Size(Data)
	$Apps.scale.y = Calculate_Module_Size(Apps)
	$SO.scale.y = Calculate_Module_Size(So)
	
	$Data.position.y = $Data.scale.y * 32
	$Apps.position.y = $Data.position.y + $Data.scale.y * 32 + $Apps.scale.y * 32 
	$SO.position.y = $Background.scale.y * 2 * 32 - ($SO.scale.y * 32)

func _ready() -> void:
	Update_Ui()

func _on_data_button_pressed(module: Module) -> void:
	Data_Selected.emit(module)

func _on_apps_button_pressed(module: Module) -> void:
	Apss_Selected.emit(module)

func _on_so_button_pressed(module: Module) -> void:
	SO_Selected.emit(module)
