extends Node2D

@export var gotita_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_gotita_timeout() -> void:
	var gotita = gotita_scene.instantiate()
	add_child(gotita)
