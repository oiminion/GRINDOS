extends Node2D

@export var Selected: Module = null
@export var segmentation_size: float = 50:
	get:
		return segmentation_size
	set(value):
		segmentation_size = value
		$RAM_fixo.Update_Segmentation_Quantity()

@export var interruption: bool = false

func Change_CPU_Color(cpu_var: Module, process: Module) -> void:
	if process.color != Color.WHITE:
		cpu_var.connect_ContextColor(process.color)
	else:
		cpu_var.clear_Context()

func Connect_CPU(module: Module) -> void:
	if not interruption:
		if module is Context or Selected is Context:
			if(module is Context):
				_on_ram_fixo_context_selected(module)
			else:
				_on_ram_fixo_context_selected(Selected)
			return
		$RAM_fixo.Clear_CPU_Connected.emit()
		$CableCPU.Connect_Module(Selected, module)
		if module == $CPU:
			if (module.color == Color.WHITE and Selected.can_change_CPU_color) or module.color == Selected.color:
				Selected.Connect_CPU()
				if Selected.can_change_CPU_color:
					Change_CPU_Color(module, Selected)
					Selected.can_change_CPU_color = false
		elif Selected is Context:
			$RAM_fixo.Clear_CPU_Connected.emit()
			if $CPU.color == Color.WHITE and Selected.color != Color.WHITE:
				$CPU.connect_ContextColor(Selected.color)
				Selected.clearColor()
			elif $CPU.color != Color.WHITE and Selected.color == Color.WHITE:
				Selected.changeColor($CPU.color)
				$CPU.clear_Context()
			$CableCPU.Connect_Context($CPU,Selected)
		else:
			if (Selected.color == Color.WHITE and module.can_change_CPU_color) or module.color == Selected.color:
				module.Connect_CPU()
				if module.can_change_CPU_color: 
					Change_CPU_Color(Selected, module)
					module.can_change_CPU_color = false
	else:
		if module == $CPU:
			if Selected.is_interruption:
				if (module.color == Color.WHITE and Selected.can_change_CPU_color) or module.color == Selected.color:
					Selected.Connect_CPU()
					if Selected.can_change_CPU_color:
						Change_CPU_Color(module, Selected)
						Selected.can_change_CPU_color = false
		else:
			if module.is_interruption:
				if (Selected.color == Color.WHITE and module.can_change_CPU_color) or module.color == Selected.color:
					module.Connect_CPU()
					if module.can_change_CPU_color: 
						Change_CPU_Color(Selected, module)
						module.can_change_CPU_color = false
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
	else:
		Selected = null

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
	else:
		Selected = null

func _on_disk_data_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_Disk_Data(module)
	else:
		Selected = null

func _on_disk_apss_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_Disk_Apps(module)
	else:
		Selected = null

func _on_disk_so_selected(_module: Module) -> void:
	pass


func _on_ram_fixo_context_selected(context: Context) -> void:
	if Selected == null:
		Selected = context
	elif Selected == $CPU or Selected is Context:
		$RAM_fixo.Clear_CPU_Connected.emit()
		if $CPU.color == Color.WHITE and context.color != Color.WHITE:
			$CPU.connect_ContextColor(context.color)
			context.clearColor()
		elif $CPU.color != Color.WHITE and context.color == Color.WHITE:
			context.changeColor($CPU.color)
			$CPU.clear_Context()
		$CableCPU.Connect_Context($CPU,context)
		Selected = null
	else:
		Selected = null
		

func _on_ram_fixo_completed_process() -> void:
	$CPU.clear_Context()

func _on_ram_fixo_change_cpu_color(color: Color) -> void:
	$CPU.connect_ContextColor(color)


func _on_ram_fixo_clear_context(color: Color) -> void:
	if $CPU.color == color:
		$CPU.clear_Context()


func _on_ram_fixo_created_interruption() -> void:
	interruption = true
