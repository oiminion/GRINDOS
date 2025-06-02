extends Panel

class_name Upgrade

signal Unlocked(upgrade: Upgrade)

@export var price: int
@export var upgrade_name: String
@export var list_position: int

func _on_button_2_button_down() -> void:
	if Global.points >= price:
		Global.points -= price
		Unlocked.emit(self)
