extends Area2D

const gotita_scene: PackedScene = preload("res://gotita.tscn")


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass


func _on_body_entered(body:Node2D) -> void:
	if body.scene_file_path == gotita_scene.resource_path and body.estado == body.Estados.GASEOSO:
		body.morir()
		# TODO: animación gotita evaporándose
