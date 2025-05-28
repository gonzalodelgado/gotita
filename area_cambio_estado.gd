extends Area2D

const drag_helper = preload("res://drag_helper.gd")
var dragging: bool = false
var estado: String
var nivel
@export var gotita_scene: PackedScene


func _ready() -> void:
	# TODO: cambiar get_parent por búsqueda o función
	nivel = get_parent()

func _process(delta: float) -> void:
	for node in nivel.get_children():
		if node.scene_file_path == gotita_scene.resource_path:
			if overlaps_body(node):
				_on_body_entered(node)
			else:
				_on_body_exited(node)

func _input(event):
	drag_helper.handle_input_for_drag(event, self)

func _on_body_entered(body:Node2D) -> void:
	if body.scene_file_path == gotita_scene.resource_path:
		if dragging:
			var tween = get_tree().create_tween()
			tween.tween_property(body, "scale", Vector2(1.4, 1.4), 0.1)
			tween.tween_property(body, "modulate", Color.PALE_GREEN, 0.2)
		else:
			body.cambiar_estado(estado)

func _on_body_exited(body: Node2D) -> void:
	if body.scene_file_path == gotita_scene.resource_path:
		body.scale = Vector2(1, 1)
		body.modulate = Color(1,1,1,1)


func get_drag_obj():
	return self

func get_drag_radius():
	return 24

func init(estado_str, label_text: String="💧"):
	dragging = false
	estado = estado_str
	$Label.text = label_text
	return self
	
''' NO ESTÁ FUNCIONANDO
func drop():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		_on_body_entered(body)
'''
