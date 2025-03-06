extends Sprite2D

func Connect_Module(module1: Module, module2: Module) -> void:
	self.global_position = (module1.global_position + module2.global_position) / 2
	look_at(module2.global_position)
	var distance = module1.global_position.distance_to(module2.global_position)
	scale.x = distance / 65
