extends Sprite2D

func Connect_Module(module1: Module, module2: Module) -> void:
	self.global_position = (module1.global_position + module2.global_position) / 2
	look_at(module2.global_position)
	var distance = module1.global_position.distance_to(module2.global_position)
	scale.x = distance / 65

func Connect_Context(module: Module, context: Context) -> void:
	self.global_position = (module.global_position + context.global_position) / 2
	look_at(context.global_position)
	var distance = module.global_position.distance_to(context.global_position)
	scale.x = distance / 65
