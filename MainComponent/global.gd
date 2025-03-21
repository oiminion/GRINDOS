extends Node

signal Points_Changed

var points: int = 0:
	get:
		return points
	set(value):
		points = value
		Points_Changed.emit()

var RAM_max_capacity: float = 200
var segmentation_size: float = 50

var disk_max_capacity: float = 200

var unlocked_upgrades: Dictionary = {}
