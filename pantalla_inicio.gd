extends Node2D

@onready var screen_size = get_viewport_rect().size
signal jugar_pressed
signal salir_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.position.x = screen_size.x/2 - $Menu.size.x/2
	$Menu.position.y = screen_size.y - $Menu.size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_boton_salir_pressed() -> void:
	salir_pressed.emit()


func _on_boton_jugar_pressed() -> void:
	jugar_pressed.emit()
