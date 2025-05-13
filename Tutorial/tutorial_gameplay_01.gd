extends Node2D


@export var Selected: Module = null

@export var segmentation_size: float = 50

var ended: bool = false

var array: Array = [
		"aqui será o tutorial do jogo",
		"conecte o SO para as caixas de RAM"
	]

func _ready() -> void:
	$character_layer.setStringArray(array)

func _on_character_layer_finished_talk() -> void:
	# tutorial_progress += 1	
	match TutorialProgress.tutorial_progress:
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
		
func _on_ram_fixo_module_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() != module.get_parent():
		$Cable.Connect_Module(module, Selected)
		
		
		if TutorialProgress.tutorial_progress == 0:
			$character_layer.setStringArray([
				"ótimo, essa é a mecanica básica deste jogo",
				"a próxima mecanica é "])
			TutorialProgress.tutorial_progress = 1
			$CPU.visible = 1
			$setas.visible = 0
