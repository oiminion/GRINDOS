extends Control

func babata() -> void:
	print("A")

var Upgrades: Array[Callable] = [
	babata
]

func _ready() -> void:
	Upgrades[0].call()


func _on_panel_unlocked(upgrade: Upgrade) -> void:
	Upgrades.remove_at(upgrade.list_position)
	Global.Unlock_Upgrade(upgrade.upgrade_name)
