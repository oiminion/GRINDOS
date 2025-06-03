extends Panel

class_name Upgrade

signal Unlocked(upgrade: Upgrade)

@export var price: int
@export var upgrade_name: String
@export var list_position: int

func update() -> void:
	$Name.text = upgrade_name
	$Price.text = str(price)
	self.visible = true

func updateNothing() -> void:
	self.visible = false

func _on_button_2_button_down() -> void:
	if Global.points >= price or true:
		Global.points -= price
		Unlocked.emit(self)
