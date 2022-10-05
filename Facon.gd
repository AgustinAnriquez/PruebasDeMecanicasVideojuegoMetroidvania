extends Area2D

export var danio:int = 2

func daniar(otro_cuerpo: CollisionObject2D) -> void:
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)

func _on_Facon_area_entered(area):
	daniar(area)
