extends KinematicBody2D
class_name Player

export var velocidad = Vector2(150.0, 150.0)
export var curacion:float = 0.5
export var hitpoints:float = 20.0

onready var barra_salud = $BarraSalud
onready var barra_cura = $BarraCura


var curacion_rango:float = 5.0
var max_hitpoints:float = hitpoints
var puede_curarse = true
var curacion_max:float = hitpoints * 0.25 setget ,get_curacion_max
var movimiento = Vector2.ZERO

func get_curacion_max() -> float:
	return curacion_max

func _ready() -> void:
	barra_salud.set_valores_hitpoints(hitpoints)
	barra_cura.set_valores_curacion(curacion_rango, curacion_max)

func _physics_process(delta):
	movimiento.x = velocidad.x * tomar_direccion()
	move_and_slide(movimiento, Vector2.UP)

func _unhandled_input(event):
	if event.is_action("curar"):
		validar_cura()
		if puede_curarse:
			curar()

func tomar_direccion():
	var direccion = 0
	direccion = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierda")
	return direccion

func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	barra_salud.set_valores_actual(hitpoints)
	if hitpoints == 0:
		queue_free()

func curar():
	if hitpoints == max_hitpoints:
		return
	elif (hitpoints + curacion) > max_hitpoints:
		var cura_total = curacion - hitpoints
		modificar_curacion_rango(cura_total)
		hitpoints += -(cura_total) 
	else:
		hitpoints += curacion
		modificar_curacion_rango(-curacion)
	barra_salud.set_valores_actual(hitpoints)

func validar_cura():
	if curacion_rango <= 0:
		puede_curarse = false
	else:
		puede_curarse = true

func modificar_curacion_rango(curaCount: float):
	if (curacion_rango + curaCount) <= curacion_max:
		curacion_rango += curaCount
		barra_cura.set_valores_actual(curacion_rango)
	print("barra curacion ", curacion_rango)
