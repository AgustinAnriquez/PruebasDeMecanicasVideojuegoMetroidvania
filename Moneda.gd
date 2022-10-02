extends Area2D




func _on_Moneda_body_entered(body):
	if body is Player:
		body.modificar_curacion_rango(body.get_curacion_max() * 0.2)
	queue_free()
