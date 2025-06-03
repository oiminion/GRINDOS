extends Control

var shop_slot_scene: PackedScene = preload("res://Auxiliar/Shop_slot.tscn")

func displayUpgrade(display: Upgrade,upgrade_name: String, upgrade_price: int) -> void:
	display.price = upgrade_price
	display.upgrade_name = upgrade_name
	display.update()

func displayNothing(display: Upgrade) -> void:
	display.price = 0
	display.upgrade_name = ""
	display.updateNothing()

func interruptionUpgrade(display: Upgrade) -> void:
	displayUpgrade(display,"interrupção",10)

var Upgrades: Array[Callable] = [
	interruptionUpgrade
]

var Displays: Array[Upgrade] = []

func updateDisplays() -> void:
	for i in 8:
		if i < Upgrades.size():
			Upgrades[i].call(Displays[i])
		else:
			displayNothing(Displays[i])

func _ready() -> void:
	for i in 8:
		var instance = shop_slot_scene.instantiate()
		$VBoxContainer.add_child(instance)
		instance.Unlocked.connect(_on_panel_unlocked)
		instance.list_position = i
		Displays.append(instance)
		if i < Upgrades.size():
			Upgrades[i].call(instance)
		else:
			displayNothing(instance)


func _on_panel_unlocked(upgrade: Upgrade) -> void:
	Upgrades.remove_at(upgrade.list_position)
	Global.Unlock_Upgrade(upgrade.upgrade_name)
	updateDisplays()
