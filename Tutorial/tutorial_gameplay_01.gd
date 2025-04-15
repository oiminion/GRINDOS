extends Node2D

@export var tutorial_progress : int = 0
var ended: bool = false

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
			array = ["batata1","batata2","batata3"]
		2:
			array = ["a1","a2","a3"]
		_:
			$character_layer.visible = false
			ended = true
	if not ended:
		$character_layer.setStringArray(array)
