extends KinematicBody2D
class_name Player

#Se le da velocidad a personaje a efectos de prueba, solo para generar movimiento
export var velocidad = Vector2(150.0, 150.0)

#La variable curacion determina la velocidad con la que se va curar el personaje, mientras menor sea mas lento se va curar
export var curacion:float = 0.5

#Se da hitpoints al personaje a efectos de prueba
export var hitpoints:float = 20.0

#Se crea barra de salud a efectos de prueba
onready var barra_salud = $BarraSalud

# progressbar, donde se visualizan cambios en la barra de curacion
onready var barra_cura = $BarraCura

#es la curacion disponible en barra, comienza en cero, cuando el personaje vaya recogiendo monedas esta aumenta. 20% aumenta por cada moneda recogida
var curacion_cargada:float = 0

#Se necesuta una variable con el maximo de hitpoints para evitar que el personaje se pueda recargar mas hitpoints usando la curacion
var max_hitpoints:float = hitpoints

#variable que se utilizara para controlar si el personaje puede curarse, en base a si tiene barra de cura cargada o no
var puede_curarse = true

#variable que determina el valor maximo que puede alcanzar la barra de cura, en este caso como valor maximo le di 25% de la salud total del personaje 
var curacion_max:float = hitpoints * 0.25 setget ,get_curacion_max

#Vector movimiento a efectos de prueba
var movimiento = Vector2.ZERO

#Se necesita un get del mismo para que en la clase Moneda, sea posible obtener su valor
func get_curacion_max() -> float:
	return curacion_max

#Se llena barra de salud y de cura
func _ready() -> void:
	barra_salud.set_valores_hitpoints(hitpoints)
	barra_cura.set_valores_curacion(curacion_cargada, curacion_max)

#Se le da movimiento al personaje a efectos de prueba
func _physics_process(delta):
	movimiento.x = velocidad.x * tomar_direccion()
	move_and_slide(movimiento, Vector2.UP)

func tomar_direccion():
	var direccion = 0
	direccion = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierda")
	return direccion

#Se asigna boton de cura, se va curando mientras se mantiene presionado el boton. Siempre y cuando sea posible
func _unhandled_input(event):
	if event.is_action("curar"):
		validar_cura()
		if puede_curarse:
			curar()

#A efectos de prueba se produce daño a personaje
func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	barra_salud.set_valores_actual(hitpoints)
	if hitpoints == 0:
		queue_free()

#En base a hitoints del personaje, se determina cuanto se va curar al mismo. Se modifica barra de salud y de curacion
func curar():
	if hitpoints == max_hitpoints:
		return
	elif (hitpoints + curacion) > max_hitpoints:
		var cura_total = curacion - hitpoints
		modificar_curacion_cargada(cura_total)
		hitpoints += -(cura_total) 
	else:
		hitpoints += curacion
		modificar_curacion_cargada(-curacion)
	barra_salud.set_valores_actual(hitpoints)

#Se cambia el valor de variable puede_curarse en base a si tiene cura cargada o no
func validar_cura():
	if curacion_cargada <= 0:
		puede_curarse = false
	else:
		puede_curarse = true

#Se va modificando la curacion cargada en la barra, cuando se agarren monedas o cuando se cura el personaje
func modificar_curacion_cargada(curaCount: float):
	if (curacion_cargada + curaCount) <= curacion_max:
		curacion_cargada += curaCount
		barra_cura.set_valores_actual(curacion_cargada)
	print("barra curacion ", curacion_cargada)
