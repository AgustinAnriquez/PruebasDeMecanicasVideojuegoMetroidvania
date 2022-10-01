extends ProgressBar
class_name BarraSalud

func set_hitpoints_actual(hitpoints: float) -> void:
	value = hitpoints

func set_valores(hitpoints: float) -> void:
	max_value = hitpoints
	value = hitpoints
