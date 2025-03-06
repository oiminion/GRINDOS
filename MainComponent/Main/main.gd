extends Node2D

@export var Selected: Module = null

func _on_cpu_button_pressed(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() == $Disk:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		$CableCPU.Connect_Module(Selected, module)
		Selected.Connect_CPU()
		Selected = null

func _on_ram_fixo_module_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		$CableCPU.Connect_Module(Selected, module)
		Selected = null
	elif Selected.get_parent() == $Disk:
		$CableDisk.Connect_Module(Selected, module)
		Selected = null

func _on_disk_module_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		$CableDisk.Connect_Module(Selected, module)
		Selected = null
