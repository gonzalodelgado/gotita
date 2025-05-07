extends Node2D

@export var max_gotitas = 1
@export var gotita_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_gotita_timeout() -> void:
	var cantidad_gotitas = get_children().filter(func(child): return child.scene_file_path == gotita_scene.resource_path).size()
	if cantidad_gotitas < max_gotitas:
		var gotita = gotita_scene.instantiate()
		gotita.position.x = 10
		add_child(gotita)


func cambiar_estado(estado):
	var gotitas = get_children().filter(func(child): return child.scene_file_path == gotita_scene.resource_path)
	for gotita in gotitas:
		gotita.cambiar_estado(estado)

func _on_boton_gaseoso_pressed() -> void:
	cambiar_estado("GASEOSO")


func _on_boton_solido_pressed() -> void:
	cambiar_estado("SOLIDO")


func _on_boton_liquido_pressed() -> void:
	cambiar_estado("LIQUIDO")


func _on_area_liquido_body_entered(body:Node2D) -> void:
	if body.scene_file_path == gotita_scene.resource_path:
		print("BODY entro liquido", body)
		body.cambiar_estado("LIQUIDO")
