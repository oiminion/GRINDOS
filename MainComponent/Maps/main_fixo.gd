extends Node2D

@export var Selected: Module = null
@export var segmentation_size: float = 50:
	get:
		return segmentation_size
	set(value):
		segmentation_size = value
		$RAM_fixo.Update_Segmentation_Quantity()

func Connect_CPU(module: Module) -> void:
	$RAM_fixo.Clear_CPU_Connected.emit()
	$CableCPU.Connect_Module(Selected, module)
	if module == $CPU:
		Selected.Connect_CPU()
	else:
		module.Connect_CPU()
	Selected = null

func Connect_Disk_Cable(module: Module) -> void:
	$CableDisk.Connect_Module(Selected, module)
	Selected = null

func Connect_Disk_Data(module: Module) -> void:
	$RAM_fixo.Clear_Data_Connected.emit()
	if module == $Disk/Data:
		Selected.Connect_Data()
	else:
		module.Connect_Data()
	Connect_Disk_Cable(module)

func Connect_Disk_Apps(module: Module) -> void:
	$RAM_fixo.Clear_Apps_Connected.emit()
	if module == $Disk/Apps:
		Selected.Connect_Apps()
	else:
		module.Connect_Apps()
	Connect_Disk_Cable(module)

func _on_cpu_button_pressed(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() == $Disk:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_CPU(module)

func _on_ram_fixo_module_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Connect_CPU(module)
	elif Selected.get_parent() == $Disk:
		if Selected == $Disk/Data:
			Connect_Disk_Data(module)
		elif Selected == $Disk/Apps:
			Connect_Disk_Apps(module)

func _on_disk_data_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_Disk_Data(module)

func _on_disk_apss_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_Disk_Apps(module)

func _on_disk_so_selected(module: Module) -> void:
	pass
