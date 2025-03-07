extends "res://Auxiliar/module.gd"

signal Process_Completed(value: int)

@export var free: bool = true
@export var cpu_connected: bool = false
@export var data_connected: bool = false
@export var apps_connected: bool = false

@export var interruption_probability: int = 0
@export var patience: int = 0
@export var max_patience: int = 0
@export var progress: int = 0
@export var conclude: int = 0

@export var blocked: bool = false
@export var segmentation_size: int = 0

func Update_Max_Ui() -> void:
	$Control/patience_bar.max_value = max_patience
	$Control/progress_bar.max_value = conclude

func Change_Progress_Bar_Color(hex_code: String) -> void:
	var sb = StyleBoxFlat.new()
	$Control/progress_bar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color(hex_code)

func _ready():
	self.button_pressed.connect(get_parent().Process_Selected)

func Alocate_Space() -> void:
	if not free:
		print("tried to alocate alocated space")
		return
	free = false
	self.interruption_probability = randi_range(0,20)
	self.max_patience = randi_range(75,150)
	self.patience = max_patience
	self.conclude = randi_range(segmentation_size/10,segmentation_size)
	self.progress = 0
	Update_Max_Ui()
	$Control/patience_bar.visible = true
	$Control/progress_bar.visible = true

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
	self.interruption_probability = 0
	self.patience = 0
	self.progress = 0
	self.conclude = 0
	$Control/patience_bar.value = patience
	$Control/progress_bar.value = progress
	$Control/patience_bar.visible = false
	$Control/progress_bar.visible = false
	free = true

func Connect_Data() -> void:
	data_connected = true

func Connect_Apps() -> void:
	apps_connected = true

func Connect_CPU() -> void:
	cpu_connected = true

func Unblock() -> void:
	blocked = false

func _on_cycle_timer_timeout() -> void:#WIP
	if data_connected:
		Unblock()
	if cpu_connected and not blocked and not free:
		Change_Progress_Bar_Color("00ff00")
		patience = max_patience
		progress += 1
		$Control/patience_bar.value = patience
		$Control/progress_bar.value = progress
		if progress >= conclude:
			Process_Completed.emit(((conclude*10)/max_patience))
			Free_Space()
			if apps_connected:
				Alocate_Space()
		if not data_connected:
			var aux = randi_range(0,1000)
			if aux < interruption_probability:
				blocked = true
		else:
			Unblock()
	elif not free:
		patience -= 1
		$Control/patience_bar.value = patience
		if blocked:
			Change_Progress_Bar_Color("ff0000")
		else:
			Change_Progress_Bar_Color("ffffff")
		if patience <= 0:
			Free_Space()
	elif apps_connected:
		Alocate_Space()
	
