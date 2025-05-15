extends Area2D

const drag_helper = preload("res://drag_helper.gd")
var dragging: bool = false
var estado: String
@export var gotita_scene: PackedScene


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		_on_body_entered(body)

func _input(event):
	drag_helper.handle_input_for_drag(event, self)

func _on_body_entered(body:Node2D) -> void:
	if not dragging and body.scene_file_path == gotita_scene.resource_path:
		body.cambiar_estado(estado)

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
