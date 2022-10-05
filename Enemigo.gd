extends Area2D

export var hitpoints:float = 4.0
export var danio:int = 2
export var moneda:PackedScene = null

onready var punto_moneda:Position2D = $Position2D

func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	print(hitpoints)
	if hitpoints <= 0:
		var nueva_moneda:Moneda = moneda.instance()
		nueva_moneda.crear(punto_moneda.global_position)
		Eventos.emit_signal("generarMoneda", nueva_moneda)
		queue_free()
		
		
func daniar(otro_cuerpo: CollisionObject2D) -> void:
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)


func _on_Enemigo_body_entered(body: Node) -> void:
	daniar(body)
