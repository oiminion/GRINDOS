extends "res://MainComponent/RAM/ram.gd"

@export var segmentation_quantity: int

signal Module_Selected(module: Module)
signal Clear_CPU_Connected
signal Clear_Data_Connected
signal Clear_Apps_Connected

signal Change_CPU_Color(color: Color)
signal Completed_Process

signal Context_Selected(context:Context)
signal Clear_Context(color: Color)

signal Lock_Unlock_Process
signal InterruptionEnded
signal Unlock_Process_Unity

var process_scene: PackedScene = preload("res://Auxiliar/process.tscn")

signal Created_Interruption

func Lock_Unlock() -> void:
	Lock_Unlock_Process.emit()

func Change_CPU(color: Color) -> void:
	Change_CPU_Color.emit(color)

func Free_Count() -> int:
	var result: int = 0
	for child in get_children():
		if child is Module:
			if not child.free:
				result += 1
	return result

func Process_Completed(value: int) -> void:
	Global.points += (value + 1) * Free_Count()
	Completed_Process.emit()

func Calculate_Module_Size() -> float:
	return $memory_space.scale.y / Global.RAM_max_capacity * get_parent().segmentation_size

func Update_Segmentation_Quantity() -> void:
	segmentation_quantity = Global.RAM_max_capacity / get_parent().segmentation_size

func Clear_Selected_Process() -> void:
	Clear_CPU_Connected.emit()

func ClearContext(color: Color) -> void:
	$so_space.Clear_Context(color)
	Clear_Context.emit(color)

func AnnounceInterruption() -> void:
	Created_Interruption.emit()

func InterruptionCompleted() -> void:
	InterruptionEnded.emit()
	
func Unlock_Process() -> void:
	Unlock_Process_Unity.emit()

func Initialize_Ram() -> void:
	var off_set: int = Calculate_Module_Size() * 196
	for i in segmentation_quantity:
		var instance = process_scene.instantiate()
		add_child(instance)
		instance.segmentation_size = get_parent().segmentation_size
		self.Clear_CPU_Connected.connect(instance.Clear_CPU_Connected)
		self.Clear_Data_Connected.connect(instance.Clear_Data_Connected)
		self.Clear_Apps_Connected.connect(instance.Clear_Apps_Connected)
		self.Lock_Unlock_Process.connect(instance.Lock_Unlock_Process)
		self.Unlock_Process_Unity.connect(instance.Unlock_Process)
		instance.InterruptionEnded.connect(InterruptionCompleted)
		instance.CreatedInterruption.connect(AnnounceInterruption)
		instance.Process_Completed.connect(Process_Completed)
		instance.PatienceExplode.connect(ClearContext)
		instance.scale.y = Calculate_Module_Size()
		instance.position.x = 32
		if i == 0:
			instance.position.y = instance.scale.y * 32
		else:
			instance.position.y = instance.scale.y * 32 + off_set
		off_set = instance.position.y + instance.scale.y * 32

func _ready() -> void:
	segmentation = "fixo"
	segmentation_quantity = Global.RAM_max_capacity / get_parent().segmentation_size
	Initialize_Ram()

func Process_Selected(module: Module) -> void:
	Module_Selected.emit(module)


func _on_so_space_context_selected(context: Context) -> void:
	Context_Selected.emit(context)
