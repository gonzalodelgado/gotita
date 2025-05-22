extends Node2D

var indice_nivel: int = 0
var nombres_niveles: PackedStringArray
var nivel_actual
const niveles_dir = "res://niveles"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nombres_niveles = ResourceLoader.list_directory(niveles_dir)
	cargar_nivel()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func cargar_nivel():
	$BotonReintentar.visible = false
	$BotonSiguienteNivel.visible = false
	if is_instance_valid(nivel_actual):
		remove_child(nivel_actual)
		nivel_actual.queue_free()
	nivel_actual = ResourceLoader.load("%s/%s" % [niveles_dir, nombres_niveles[indice_nivel]]).instantiate()
	add_child(nivel_actual)
	nivel_actual.gano_nivel.connect(_on_gano_nivel)
	nivel_actual.perdio_nivel.connect(_on_perdio_nivel)

func _on_gano_nivel() -> void:
	$BotonSiguienteNivel.visible = true
	$BotonReintentar.text = "Otra Vez"
	$BotonReintentar.visible = true

func _on_perdio_nivel() -> void:
	$BotonReintentar.visible = true
	$BotonReintentar.text = "Otra Oportunidad"

func _on_boton_siguiente_nivel_pressed() -> void:
	indice_nivel = (indice_nivel + 1) % nombres_niveles.size()
	cargar_nivel()

func _on_boton_reintentar_pressed() -> void:
	cargar_nivel()
