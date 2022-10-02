extends ProgressBar
class_name Barra

func set_valores_actual(nuevo_value: float) -> void:
	value = nuevo_value

func set_valores_hitpoints(hitpoints: float) -> void:
	max_value = hitpoints
	value = hitpoints

#Se asigna la curacion cargada y la maxima del personaje
func set_valores_curacion(curacion_actual: float, curacion_max:float) -> void:
	max_value = curacion_max
	value = curacion_actual
