extends KinematicBody2D

export var velocidad = Vector2(150.0, 150.0)
export var curacion:float = 3.0
export var hitpoints:float = 20.0
var puede_moverse = true
onready var barra_salud:BarraSalud = $BarraSalud
var max_hitpoints:float = hitpoints

var movimiento = Vector2.ZERO

func _ready() -> void:
	barra_salud.set_valores(hitpoints)

func _physics_process(delta):
	movimiento.x = velocidad.x * tomar_direccion()
	move_and_slide(movimiento, Vector2.UP)

func _unhandled_input(event):
	if event.is_action("curar"):
		curar()

func tomar_direccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierda")
	return direccion

func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	barra_salud.set_hitpoints_actual(hitpoints)

func curar():
	if (hitpoints + curacion) > max_hitpoints:
		hitpoints = max_hitpoints 
	else:
		hitpoints += curacion
	barra_salud.set_hitpoints_actual(hitpoints)
	
