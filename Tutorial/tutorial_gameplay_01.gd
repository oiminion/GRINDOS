extends Node2D

@export var tutorial_progress : int = 0

var array: Array = [
		"lore1",
		"lore2",
		"lore3"
	]

func _ready() -> void:
	$character_layer.setStringArray(array)

func _on_character_layer_finished_talk() -> void:
	tutorial_progress += 1
	
	match tutorial_progress:
		1:
			$Disk.visible = true
		2:
			pass
	
	$character_layer.setStringArray(array)
