extends Node

signal Points_Changed

var points: int = 0:
	get:
		return points
	set(value):
		points = value
		Points_Changed.emit()

var max_capacity: float = 200
