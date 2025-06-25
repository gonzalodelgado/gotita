extends Area2D

signal gotita_salvada
@export_enum("LIQUIDO", "GASEOSO", "SOLIDO") var estado_requerido: String = "LIQUIDO"


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _on_body_entered(body:Node2D) -> void:
	if body.scene_file_path == "res://gotita.tscn" and body.estado == body.Estados.get(estado_requerido):
		$"Tragar gota".play()
		gotita_salvada.emit()
		body.queue_free()
		
