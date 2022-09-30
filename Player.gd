extends KinematicBody2D

export var velocidad = Vector2(150.0, 150.0)

var movimiento = Vector2.ZERO

func _physics_process(delta):
	movimiento.x = velocidad.x * tomar_direccion()

func tomar_direccion():
	var direccion = 0
	direccion = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierda")
	return direccion
