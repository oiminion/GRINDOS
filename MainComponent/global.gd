extends Node

signal Points_Changed

#WIP adicionar mais cores
var process_colors: PackedColorArray = PackedColorArray([
	Color(0.69675,0.31901,0.42888),
	Color(0.60407,0.94785,0.50633),
	Color(0.34241,0.86421,0.51082),
	Color(0.28623,0.99492,0.77138),
	Color(0.05499,0.47307,0.05812),
	
	Color(0.13976,0.97430,0.05900),
	Color(0.44925,0.71712,0.22794),
	Color(0.97270,0.18832,0.60954),
	Color(0.69106,0.59797,0.06023),
	Color(0.96053,0.70409,0.17234)
	])

var used_process_colors: Array = []

var points: int = 0:
	get:
		return points
	set(value):
		points = value
		Points_Changed.emit()

var max_capacity: float = 200
var SO_RAM_Size: float = 50

var RAM_max_capacity: float = 300
var SO_max_capacity: float = 10 * (RAM_max_capacity/50)

var disk_max_capacity: float = 200

var unlocked_upgrades: Dictionary = {
	"interrupção": false
}

func Unlock_Upgrade(upgrade_name: String) -> void:
	unlocked_upgrades[upgrade_name] = true

func get_Process_Color() -> Color:
	var aux :int = randi_range(0,9)
	var max_tries :int = 5
	while(used_process_colors[aux] and max_tries > 0):
		aux = randi_range(0,9)
		max_tries -= 1
	while(used_process_colors[aux]):
		aux += 1
		if aux >= 9:
			aux = 0
	used_process_colors[aux] = true
	return process_colors[aux]

func free_Process_Color(process_color: Color) -> void:
	var aux :int = 0
	while( process_colors[aux] != process_color):
		aux += 1
	used_process_colors[aux] = false

func _ready() -> void:
	for i in process_colors.size():
		used_process_colors.append(false)
