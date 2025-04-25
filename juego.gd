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
