extends Node2D

var max_gotitas = 10
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
		add_child(gotita)
