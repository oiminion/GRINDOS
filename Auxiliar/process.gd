extends "res://Auxiliar/module.gd"

class_name Process

signal Process_Completed(value: int)

signal Change_CPU(color: Color)

signal PatienceExplode(color: Color)

signal InterruptionEnded

signal CreatedInterruption

@export var can_interrupt: bool = false
@export var is_interruption: bool = false

@export var can_change_CPU_color: bool = true

@export var free: bool = true
@export var cpu_connected: bool = false
@export var data_connected: bool = false
@export var apps_connected: bool = false

@export var data_probability: int = 0
@export var patience: int = 0
@export var max_patience: int = 0
@export var progress: int = 0
@export var conclude: int = 0

@export var blocked: bool = false
@export var segmentation_size: int = 0

var cpu_color: Color = Color.WHITE
var color: Color = Color.WHITE

func Lock_Unlock_Process() -> void:
	patience += (max_patience - patience) / 2
	$Background/Locked.visible = not is_interruption

func Unlock_Process() -> void:
	$Background/Locked.visible = false

func Update_Max_Ui() -> void:
	$Control/patience_bar.max_value = max_patience
	$Control/progress_bar.max_value = conclude

func Change_Progress_Bar_Color(hex_code: String) -> void:
	var sb = StyleBoxFlat.new()
	$Control/progress_bar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color(hex_code)
	color = Color(hex_code)

func _ready():
	self.button_pressed.connect(get_parent().Process_Selected)
	self.Change_CPU.connect(get_parent().Change_CPU)
	self.data_probability = 0
	self.patience = 0
	self.progress = 0
	self.conclude = 0
	color = Color.WHITE
	$Control/patience_bar.value = patience
	$Control/progress_bar.value = progress
	$Control/patience_bar.visible = false
	$Control/progress_bar.visible = false
	free = true
	is_interruption = false
	can_change_CPU_color = true

func Alocate_Space() -> void:
	if not free:
		print("tried to alocate alocated space")
		return
	can_change_CPU_color = true
	free = false
	self.data_probability = randi_range(0,20)
	self.max_patience = randi_range(150,200) * Global.patience_upgrade
	self.patience = max_patience
	self.conclude = randi_range(segmentation_size/5,segmentation_size)*2
	self.progress = 0
	color = Global.get_Process_Color()
	$Control/progress_bar.self_modulate = color
	Update_Max_Ui()
	$Control/patience_bar.visible = true
	$Control/progress_bar.visible = true
	#WIP
	if Global.unlocked_upgrades["interrupção"] and randi_range(0,100) <= 5:
		is_interruption = true
		CreatedInterruption.emit()
	
	if cpu_connected and can_change_CPU_color:
		Change_CPU.emit(color)
		can_change_CPU_color = false
		
	if get_parent().get_parent().interruption > 0:
		Lock_Unlock_Process()

func Clear_Data_Connected() -> void:
	data_connected = false
	apps_connected = false

func Clear_Apps_Connected() -> void:
	apps_connected = false
	data_connected = false

func Clear_CPU_Connected() -> void:
	cpu_connected = false

func Free_Space() -> void:
	if free:
		print("tried to free free space")
		return
	self.data_probability = 0
	self.patience = 0
	self.progress = 0
	self.conclude = 0
	Global.free_Process_Color(color)
	color = Color.WHITE
	$Control/patience_bar.value = patience
	$Control/progress_bar.value = progress
	$Control/patience_bar.visible = false
	$Control/progress_bar.visible = false
	free = true
	is_interruption = false
	can_change_CPU_color = true

func Connect_Data() -> void:
	data_connected = true

func Connect_Apps() -> void:
	apps_connected = true

func Connect_CPU() -> void:
	cpu_connected = true

func Unblock() -> void:
	blocked = false

func _on_cycle_timer_timeout() -> void:#WIP
	if not blocked:
		var sb = StyleBoxFlat.new()
		$Control/progress_bar.add_theme_stylebox_override("fill", sb)
		sb.bg_color = Color("ffffff")
	if patience <= 0 and not free:
		Global.points -= Global.points/10
		blocked = false
		PatienceExplode.emit(color)
		if is_interruption:
			InterruptionEnded.emit()
		Free_Space()
	patience -= 1
	if data_connected:
		Unblock()
	var A: bool = get_parent().get_parent().interruption
	var B: bool = is_interruption
	if cpu_connected and not free and not (A and not B) or (not A and B):
		if can_change_CPU_color:
			Change_CPU.emit(color)
			can_change_CPU_color = false
		if not blocked:
			patience = max_patience
		progress += 1 
		$Control/patience_bar.value = patience
		$Control/progress_bar.value = progress
		if progress >= conclude:
			var aux: int = randi_range(0,100)
			if aux < data_probability and not blocked:
				blocked = true
				var sb = StyleBoxFlat.new()
				$Control/progress_bar.add_theme_stylebox_override("fill", sb)
				sb.bg_color = Color("ff0000")
			if data_connected:
				blocked = false
			if not blocked and not free:
				if is_interruption:
					Process_Completed.emit(conclude/max_patience)
				else:
					Process_Completed.emit(((conclude*10)/max_patience))
				if is_interruption:
					InterruptionEnded.emit()
				Free_Space()
			if free and apps_connected:
				Alocate_Space()
	elif not free:
		$Control/patience_bar.value = patience
		if not blocked:
			pass
			#Change_Progress_Bar_Color("ffffff")
	elif free and apps_connected:
		Alocate_Space()
	
