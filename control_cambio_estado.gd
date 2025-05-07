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
	return 32

func get_drag_obj():
	return drag_obj

func start_drag():
	drag_obj = area_cambio_estado.instantiate().init(estado)
	get_parent().add_child(drag_obj)
	drag_obj.dragging = true
	print("Start Drag", drag_obj)

func drop():
	# TODO: verificar lugar donde se hace el drop sea válido
	drag_obj.dragging = false
	drag_obj = null

func _input(event):
	drag_helper.handle_input_for_drag(event, self)
