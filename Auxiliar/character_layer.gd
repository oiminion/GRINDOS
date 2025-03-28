extends CanvasLayer

var page :int = 0
var can_go_next :bool = false

var string_array :Array



func setStringArray(strings :Array) -> void:
	string_array = strings
	page = 0
	updateText(string_array[0])

func nextText() -> void:
	if can_go_next:
		page += 1
		updateText(string_array[page])

func changeDelay(delay :float) -> void:
	$Timer.wait_time = delay

func skipText() -> void:
	$Panel/RichTextLabel.visible_ratio = 1
	can_go_next = true

func updateText(input: String) -> void:
	can_go_next = false
	$Panel/RichTextLabel.text = input
	$Panel/RichTextLabel.visible_characters = 0
	$Timer.start()

func _on_timer_timeout() -> void:
	$Panel/RichTextLabel.visible_characters += 1
	if $Panel/RichTextLabel.visible_characters < $Panel/RichTextLabel.text.length() and not can_go_next:
		$Timer.start()
	else:
		can_go_next = true
