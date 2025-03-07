extends Control

func Update_Points() -> void:
	$number_points.text = str(Global.points)

func _ready() -> void:
	Update_Points()
	Global.Points_Changed.connect(Update_Points)
