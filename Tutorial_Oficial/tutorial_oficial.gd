extends Node2D

var TutorialCounter = 0

var array: Array = [
		"Olá eu sou a BIOS.\nClique no balão de fala para continuar",
		"Sou responsável pela iniciação do computador",
		"Primeiro vamos checar se todos os componentes do computador estão funcionando"
	]

func _ready() -> void:
	$character_layer.changeName("BIOS")
	$character_layer.setStringArray(array)

func _on_character_layer_finished_talk() -> void:
	if TutorialCounter == 0:
		array = ["Essa é a memória secundária, ela é responsável por armazenar os valores de maneira permanente"]
		$character_layer.setStringArray(array)
		
	elif TutorialCounter == 1:
		pass
	TutorialCounter += 1
