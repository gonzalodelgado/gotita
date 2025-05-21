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
	if is_instance_valid(nivel_actual):
		remove_child(nivel_actual)
		nivel_actual.queue_free()
	nivel_actual = ResourceLoader.load("%s/%s" % [niveles_dir, nombres_niveles[indice_nivel]]).instantiate()
	add_child(nivel_actual)
	nivel_actual.gano_nivel.connect($SiguienteNivelTimer.start)

func _on_siguiente_nivel_timer_timeout() -> void:
	indice_nivel = (indice_nivel + 1) % nombres_niveles.size()
	cargar_nivel()
