extends Node2D

var segmentation_size :int = 10
@export var segmentation_quantity: int

signal Context_Selected(context: Context)
signal Clear_Context_Connected

var context_scene: PackedScene = preload("res://Auxiliar/context.tscn")

func Free_Count() -> int:
	var result: int = 0
	for child in get_children():
		if child is Context:
			if not child.free:
				result += 1
	return result

func Calculate_Context_Size() -> float:
	return ($Background.scale.y / Global.SO_max_capacity) * segmentation_size * 2

func Update_Segmentation_Quantity() -> void:
	segmentation_quantity = Global.SO_max_capacity / segmentation_size

func Clear_Selected_Process() -> void:
	Clear_Context_Connected.emit()

func Context_Module_Selected(context: Context) -> void:
	Context_Selected.emit(context)

func Initialize_SO_Space() -> void:
	var off_set: int = Calculate_Context_Size() * 128
	for i in segmentation_quantity:
		var instance = context_scene.instantiate()
		add_child(instance)
		#instance.contextSelected.connect(Context_Selected)
		instance.scale.y = Calculate_Context_Size()
		instance.position.x = 32
		if i == 0:
			instance.position.y = instance.scale.y * 16
		else:
			instance.position.y = instance.scale.y * 16 + off_set + 2
		off_set = instance.position.y + instance.scale.y * 16

func _ready() -> void:
	Update_Segmentation_Quantity()
	Initialize_SO_Space()
