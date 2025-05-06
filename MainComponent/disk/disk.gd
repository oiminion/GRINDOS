extends Node2D

signal Apss_Selected(module: Module)
signal Data_Selected(module: Module)

@export var Data: float = 60:
	get:
		return Data
	set(value):
		Data = value
		Update_Ui()
@export var Apps: float = 40:
	get:
		return Apps
	set(value):
		Apps = value
		Update_Ui()

@export var connected: Module = null



func Calculate_Module_Size(value: float) -> float:
	return $Background.scale.y / Global.disk_max_capacity * value

func Update_Ui() -> void:
	$Data.scale.y = Calculate_Module_Size(Data)
	$Apps.scale.y = Calculate_Module_Size(Apps)
	
	$Data.position.y = $Data.scale.y * 32
	$Apps.position.y = $Data.position.y + $Data.scale.y * 32 + $Apps.scale.y * 32 

func _ready() -> void:
	Update_Ui()

func _on_data_button_pressed(module: Module) -> void:
	Data_Selected.emit(module)

func _on_apps_button_pressed(module: Module) -> void:
	Apss_Selected.emit(module)
