extends "res://Auxiliar/module.gd"

@export var free: bool = true

@export var interruption_probability: float = 0.0
@export var patience: int = 0
@export var progress: int = 0
@export var conclude: int = 0

func Alocate_Space(interruption_probability: float, patience: int, conclude: int) -> void:
	if not free:
		print("tried to alocate alocated space")
		return
	free = false
	self.interruption_probability = interruption_probability
	self.patience = patience
	self.progress = 0
	self.conclude = conclude

func Free_Space() -> void:
	if free:
		print("tried to free free space")
		return
	self.interruption_probability = 0
	self.patience = 0
	self.progress = 0
	self.conclude = 0
	free = true
