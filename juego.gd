extends Node2D

var indice_niveles: PackedStringArray
const niveles_dir = "res://niveles"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	indice_niveles = ResourceLoader.list_directory(niveles_dir)
	var current_level = ResourceLoader.load("%s/%s" % [niveles_dir, indice_niveles[0]]).instantiate()
	add_child(current_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
