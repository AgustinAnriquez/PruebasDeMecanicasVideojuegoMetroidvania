extends KinematicBody2D

export var velocidad = Vector2(150.0, 150.0)
export var curacion:float = 0.5
var curacion_rango:float = 0
export var curacion_max:float = 5.0
export var hitpoints:float = 20.0
onready var barra_salud = $BarraSalud
var max_hitpoints:float = hitpoints
onready var barra_cura = $BarraCura
var puede_curarse = true

var movimiento = Vector2.ZERO

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
		var cura_total = -(curacion - hitpoints)
		hitpoints += cura_total 
		curacion_rango -= cura_total
	else:
		hitpoints += curacion
		curacion_rango -= curacion
	barra_salud.set_valores_actual(hitpoints)
	barra_cura.set_valores_actual(curacion_rango)
	validar_cura()

func validar_cura():
	if curacion_rango == 0:
		puede_curarse = false
