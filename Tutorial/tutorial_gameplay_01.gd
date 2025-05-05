extends Node2D


@export var Selected: Module = null

@export var segmentation_size: float = 50

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


func _on_so_so_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() != module.get_parent():
		$Cable.Connect_Module(module, Selected)
	print("A")


func _on_ram_fixo_module_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() != module.get_parent():
		$Cable.Connect_Module(module, Selected)
 
