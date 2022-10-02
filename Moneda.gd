extends Area2D




func _on_Moneda_body_entered(body):
	#Cuando el personaje agarre una moneda la barra de curacion se recarga en un 20% 
	if body is Player:
		body.modificar_curacion_cargada(body.get_curacion_max() * 0.2)
	queue_free()
