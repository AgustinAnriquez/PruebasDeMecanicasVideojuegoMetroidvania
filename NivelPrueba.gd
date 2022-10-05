extends Node2D

class_name Nivel

onready var contenedor_monedas:Node

func _ready()-> void:
	crear_contenedores()
	Eventos.connect("generarMoneda", self, "_on_generarMoneda")
	

func crear_contenedores() -> void:
	contenedor_monedas = Node.new()
	contenedor_monedas.name = "ContenedorMonedas"
	add_child(contenedor_monedas)

func _on_generarMoneda(moneda:Moneda) -> void:
	contenedor_monedas.add_child(moneda)
