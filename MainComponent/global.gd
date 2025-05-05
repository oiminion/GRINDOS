extends Node

signal Points_Changed

var process_colors: PackedColorArray = PackedColorArray([
	Color(0.69675,0.31901,0.42888),
	Color(0.60407,0.94785,0.50633),
	Color(0.34241,0.36421,0.31082),
	Color(0.28623,0.99492,0.77138),
	Color(0.05499,0.47307,0.05812),
	
	Color(0.13976,0.97430,0.05900),
	Color(0.44925,0.71712,0.22794),
	Color(0.97270,0.18832,0.60954),
	Color(0.69106,0.59797,0.06023),
	Color(0.96053,0.70409,0.17234)
	])

var used_process_colors: Array = [
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false
]

var points: int = 0:
	get:
		return points
	set(value):
		points = value
		Points_Changed.emit()

<<<<<<< HEAD
var max_capacity: float = 200
var SO_RAM_Size: float = 50
=======
var RAM_max_capacity: float = 500

var disk_max_capacity: float = 200

var unlocked_upgrades: Dictionary = {}

func get_Process_Color() -> Color:
	var aux :int = randi_range(0,9)
	while(used_process_colors[aux]):
		aux += 1
		if aux >= 9:
			aux = 0
	
	used_process_colors[aux] = true
	return process_colors[aux]

func free_Process_Color(process_color: Color) -> void:
	var aux :int = 0
	print(process_color)
	while( process_colors[aux] != process_color):
		aux += 1
	used_process_colors[aux] = false
>>>>>>> 50a5e965d2988d8b149a3261d7de48897996e5f8
