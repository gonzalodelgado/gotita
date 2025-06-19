extends StaticBody2D

@onready var coll_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@onready var screen_size = get_viewport_rect().size
@export var max_gotitas = 10
@export var gotitas_objetivo = 8
@export var gotita_scene: PackedScene
@export var modo_creativo: bool = false
@export_enum("LIQUIDO", "GASEOSO", "SOLIDO") var estado_inicial: String

enum Estados {PLAY, WIN, LOSE}
@onready var estado: Estados = Estados.PLAY
var gotitas_generadas = 0
var gotitas_salvadas = 0
var gotitas_perdidas = 0
var estado_generador_index = 0
var labels_por_estado = {
	"LIQUIDO": "💧",
	"SOLIDO": "🧊",
	"GASEOSO": "☁"
	}
signal gano_nivel
signal perdio_nivel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GanasteLabel.visible = false
	$PerdisteLabel.visible = false
	$ContadorLabel.visible = true
	$ContadorLabel.text = "Gotitas: " + str(gotitas_salvadas) + "/" + str(gotitas_objetivo)
	for coll_poly in find_children("*", "CollisionPolygon2D", false):
		polygon_2d = coll_poly.find_child("Polygon2D")
		polygon_2d.polygon = coll_poly.polygon
		polygon_2d.offset = Vector2(coll_polygon_2d.position)
		polygon_2d.position = Vector2(polygon_2d.position)
	gotitas_generadas = 0
	if $GeneradorGotitas:
		$GeneradorGotitas.text = "💧"

func _process(_delta: float) -> void:
	var minutes_left = $TimerNivel.time_left / 60.0
	var seconds_left = int($TimerNivel.time_left) % 60
	$TimerNivelLabel.text = "%02d:%02d" % [minutes_left, seconds_left]
	$ContadorLabel.text = "Gotitas: " + str(gotitas_salvadas) + "/" + str(gotitas_objetivo)
	if estado == Estados.PLAY and gotitas_salvadas >= gotitas_objetivo and not modo_creativo:
		estado = Estados.WIN
		$ContadorLabel.visible = false
		gano_nivel.emit()

	if estado == Estados.PLAY and gotitas_perdidas > gotitas_objetivo and not modo_creativo:
		perder()

func perder() -> void:
	estado = Estados.LOSE
	perdio_nivel.emit()

func generar_gotita(pos, estado):
	var gotita = gotita_scene.instantiate()
	gotita.cambiar_estado(estado)
	gotita.position = Vector2(pos)
	add_child(gotita)
	gotitas_generadas += 1
	# gotita.murio.connect($PerdidaGotita.play)
	gotita.murio.connect(func(): gotitas_perdidas += 1)

func _input(event):
	if $GeneradorGotitas:
		if event is InputEventKey and event.is_pressed():
			var index_offset = 0
			if event.keycode == KEY_LEFT or event.keycode == KEY_UP:
				index_offset = -1
			elif event.keycode == KEY_RIGHT or event.keycode == KEY_DOWN:
				index_offset = 1
			if index_offset:
				estado_generador_index = (estado_generador_index + index_offset) % 3
				var nuevo_estado = labels_por_estado.keys()[estado_generador_index]
				$GeneradorGotitas.text = labels_por_estado[nuevo_estado]
		elif event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			generar_gotita(event.position, labels_por_estado.keys()[estado_generador_index])
		elif event is InputEventMouseMotion:
			$GeneradorGotitas.position = Vector2(event.position)

func _on_timer_gotita_timeout() -> void:
	if gotitas_generadas < max_gotitas:
		generar_gotita(Vector2(10, 0), estado_inicial)

func _on_objetivo_body_entered(body:Node2D) -> void:
	if body.scene_file_path == gotita_scene.resource_path:
		print("BODY entro objetivo", body)
		body.queue_free()
		gotitas_salvadas += 1
		$"Objetivo/Tragar gota".play()

func _on_gano_nivel() -> void:
	$GanasteLabel.position.x = screen_size.x / 2 - $GanasteLabel.size.x / 2
	$GanasteLabel.position.y = screen_size.y / 2 - $GanasteLabel.size.y / 2
	$GanasteLabel.visible = true
	$"Win FX".play()

func _on_perdio_nivel() -> void:
	$PerdisteLabel.position.x = screen_size.x / 2 - $PerdisteLabel.size.x / 2
	$PerdisteLabel.position.y = screen_size.y / 2 - $PerdisteLabel.size.y / 2
	$PerdisteLabel.visible = true
	$"Lose FX".play()
