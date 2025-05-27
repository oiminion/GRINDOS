extends Node2D


@export var Selected: Module = null

@export var segmentation_size: float = 50

var ended: bool = false

var array: Array = [
		"tutorial do jogo, aperte no diálogo para prosseguir",
		"carregue o SO para as partições da RAM",
		"aperte nos locais indicados para conectar-lás"
	]

func _ready() -> void:
	$character_layer.setStringArray(array)

func _on_character_layer_finished_talk() -> void:
	# tutorial_progress += 1	
	match TutorialProgress.tutorial_progress:
		_:
			$character_layer.visible = false
			ended = true
	if not ended:
		$character_layer.setStringArray(array)


func _on_so_so_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() != module.get_parent() and module == $SO:
		$CableDisk.Connect_Module(module, Selected)

		if(TutorialProgress.tutorial_progress == 0 ):
			primeiroTutorialCompleto()
		Selected == null
		


func primeiroTutorialCompleto() -> void:
	$character_layer.setStringArray([
		"ótimo, essa é a mecanica básica deste jogo, conectar as coisas",
		"a próxima mecanica é a CPU processar os processos da RAM",
		"faça a mesma coisa, porém conectando o SO com alguma partição da RAM"
		])
	TutorialProgress.tutorial_progress = 1
	$CPU.visible = 1
	$Disk.visible = 1
	$SO.visible = 0;
	$setas.segundoTutorial()
	Selected = null

func segundoTutorialCompleto() -> void:
	$character_layer.setStringArray([
		"conectar a CPU nos blocos de RAM faz processar os processos",
		"completar os processos é importante, isso faz a máquina mover",
		"carregue"
		])
	$setas.terceiroTutorial()
	TutorialProgress.tutorial_progress = 2

func Connect_CPU(module: Module) -> void:
	$RAM_fixoTutorial.Clear_CPU_Connected.emit()
	$CableCPU.Connect_Module(Selected, module)
	if module == $CPU:
		Selected.Connect_CPU()
	else:
		module.Connect_CPU()
	Selected = null
	
	if( TutorialProgress.tutorial_progress == 1 ):
		segundoTutorialCompleto()
	
func _on_cpu_button_pressed(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() == $Disk or Selected == $SO:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_CPU(module)


func Connect_Disk_Cable(module: Module) -> void:
	$CableDisk.Connect_Module(Selected, module)
	Selected = null

func Connect_Disk_Data(module: Module) -> void:
	$RAM_fixoTutorial.Clear_Data_Connected.emit()
	if module == $Disk/Data:
		Selected.Connect_Data()
	else:
		module.Connect_Data()
	Connect_Disk_Cable(module)

func Connect_Disk_Apps(module: Module) -> void:
	$RAM_fixoTutorial.Clear_Apps_Connected.emit()
	if module == $Disk/Apps:
		Selected.Connect_Apps()
	else:
		module.Connect_Apps()
	Connect_Disk_Cable(module)

func _on_disk_data_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_Disk_Data(module)
	Selected = null

func _on_disk_apss_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected == $CPU:
		Selected = null
	elif Selected.get_parent() != module.get_parent():
		Connect_Disk_Apps(module)
	Selected = null

func _on_disk_so_selected(_module: Module) -> void:
	pass


func _on_ram_fixo_tutorial_module_selected(module: Module) -> void:
	if Selected == null:
		Selected = module
	elif Selected.get_parent() == $RAM_fixoTutorial and Selected != module:
		Selected = module
	elif Selected.get_parent() != module.get_parent():
		$CableDisk.Connect_Module(module, Selected)
		
		if(TutorialProgress.tutorial_progress == 0 ):
			primeiroTutorialCompleto()
	Selected == null

func _process(delta: float) -> void:
	if( Selected == null ):
		$select.visible = 0
	
	if( Selected != null ):
		$select.position = Selected.global_position 
		$select.visible = 1
		$select.rotation += 0.05
