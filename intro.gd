extends Button

signal finished_intro

var page :int = 0
var can_go_next :bool = false

var string_array :Array

func setStringArray(strings :Array) -> void:
	string_array = strings
	page = 0
	self.visible = true
	updateText(string_array[0])

func nextText() -> void:
	page += 1
	if page == string_array.size():
		self.visible = false
		finished_intro.emit()
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
	var array: Array = ["O sistema operacional é o programa que gerencia tudo que se acontece no computador.",
		"Porém este computador perdeu seu sistema operacional e cabe a você substituí-lo"
	]
	setStringArray(array)
