extends Panel

signal finished_intro

var page :int = 0
var can_go_next :bool = false

var string_array :Array

func setStringArray(strings :Array) -> void:
	string_array = strings
	page = 0
	updateText(string_array[0])

func nextText() -> void:
	page += 1
	if page == string_array.size():
		print("BBBBBBBBB")
		finished_intro.emit()
		get_tree().change_scene_to_file("res://Tutorial_Oficial/tutorial_oficial.tscn")
	elif can_go_next:
		updateText(string_array[page])

func changeDelay(delay :float) -> void:
	$Timer.wait_time = delay

func skipText() -> void:
	$RichTextLabel.visible_ratio = 1
	can_go_next = true

func updateText(input: String) -> void:
	can_go_next = false
	$RichTextLabel.text = input
	$RichTextLabel.visible_characters = 0
	$Timer.start()

func _on_timer_timeout() -> void:
	if $RichTextLabel.visible_characters < $RichTextLabel.text.length() and not can_go_next:
		$RichTextLabel.visible_characters += 1
		$Timer.start()
	else:
		can_go_next = true

func _on_next_button_button_down() -> void:
	print("AAAAAAAAA")
	if can_go_next:
		nextText()
	else:
		skipText()

func _ready() -> void:
	var array: Array = ["O sistema operacional é o programa que gerencia tudo que se acontece no computador.\n\nclique para continuar",
		"Porém este computador perdeu seu sistema operacional e cabe a você substituí-lo",
		"Começaremos essa jornada ligando o computador"
	]
	setStringArray(array)
