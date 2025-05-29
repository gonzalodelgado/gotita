extends Label

const drag_helper = preload("res://drag_helper.gd")
var dragging: float = false
var drag_obj
@export var area_cambio_estado: PackedScene
@export_range(0, 1000) var cantidad: int
@export_enum("LIQUIDO", "GASEOSO", "SOLIDO") var estado: String


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func get_drag_radius():
	return 64

func get_drag_obj():
	return drag_obj

func start_drag():
	drag_obj = area_cambio_estado.instantiate().init(estado, text)
	get_parent().add_child(drag_obj)
	drag_obj.dragging = true
	drag_obj.visible = false
	print("Start Drag ", drag_obj)

func drag_validated():
	drag_obj.visible = true

func cancel_drag():
	print("Cancel Drag ", drag_obj)
	drag_obj.queue_free()

func drop():
	# TODO: verificar lugar donde se hace el drop sea válido
	print("Drop ", self)
	drag_obj.visible = true
	drag_obj.dragging = false
	drag_obj = null

func _input(event):
	drag_helper.handle_input_for_drag(event, self)


func _on_mouse_entered() -> void:
	var mouse_enter_tween = get_tree().create_tween()
	mouse_enter_tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.3)


func _on_mouse_exited() -> void:
	var mouse_exit_tween = get_tree().create_tween()
	mouse_exit_tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
