extends "res://Auxiliar/module.gd"

@export var free: bool = true
@export var connected: bool = false

@export var interruption_probability: float = 0.0
@export var patience: int = 0
@export var max_patience: int = 0
@export var progress: int = 0
@export var conclude: int = 0

func Update_Max_Ui() -> void:
	$Control/patience_bar.max_value = max_patience
	$Control/progress_bar.max_value = conclude

func _ready():
	self.button_pressed.connect(get_parent().Process_Selected)

func Alocate_Space(interruption_probability: float, max_patience: int, conclude: int) -> void:
	if not free:
		print("tried to alocate alocated space")
		return
	free = false
	self.interruption_probability = interruption_probability
	self.patience = max_patience
	self.max_patience = max_patience
	self.progress = 0
	self.conclude = conclude
	Update_Max_Ui()
	$Control/patience_bar.visible = true
	$Control/progress_bar.visible = true

func Free_Space() -> void:
	if free:
		print("tried to free free space")
		return
	self.interruption_probability = 0
	self.patience = 0
	self.progress = 0
	self.conclude = 0
	self.connected = false
	$Control/patience_bar.visible = false
	$Control/progress_bar.visible = false
	free = true

func Connect_CPU() -> void:
	connected = true

func _on_cycle_timer_timeout() -> void:#WIP
	if connected:
		patience = max_patience
		progress += 1
		$Control/progress_bar.value = progress
		if progress >= conclude:
			Free_Space()
	elif not free:
		patience -= 1
		$Control/patience_bar.value = patience
		if patience <= 0:
			Free_Space()
	
