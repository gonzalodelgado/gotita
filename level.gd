extends StaticBody2D

@onready var coll_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@onready var screen_size = get_viewport_rect().size
@export var max_gotitas = 10
@export var gotitas_objetivo = 8
@export var gotita_scene: PackedScene
@export_enum("LIQUIDO", "GASEOSO", "SOLIDO") var estado_inicial: String

enum Estados {PLAY, WIN, LOSE}
@onready var estado: Estados = Estados.PLAY
var gotitas_generadas = 0
var gotitas_salvadas = 0
var gotitas_perdidas = 0

signal gano_nivel
signal perdio_nivel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GanasteLabel.visible = false
	$PerdisteLabel.visible = false
	$ContadorLabel.visible = true
	$ContadorLabel.text = "Gotitas: " + str(gotitas_salvadas) + "/" + str(gotitas_objetivo)
	polygon_2d.polygon = coll_polygon_2d.polygon
	polygon_2d.offset = coll_polygon_2d.position
	gotitas_generadas = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ContadorLabel.text = "Gotitas: " + str(gotitas_salvadas) + "/" + str(gotitas_objetivo)
	if estado == Estados.PLAY and gotitas_salvadas >= gotitas_objetivo:
		estado = Estados.WIN
		$ContadorLabel.visible = false
		gano_nivel.emit()

	if estado == Estados.PLAY and gotitas_perdidas > gotitas_objetivo:
		estado = Estados.LOSE
		perdio_nivel.emit()

func _on_timer_gotita_timeout() -> void:
	if gotitas_generadas < max_gotitas:
		var gotita = gotita_scene.instantiate()
		gotita.cambiar_estado(estado_inicial)
		gotita.position.x = 10
		add_child(gotita)
		gotitas_generadas += 1
		gotita.murio.connect(func(): gotitas_perdidas += 1)

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

func _on_perdio_nivel() -> void:
	$PerdisteLabel.position.x = screen_size.x / 2 - $PerdisteLabel.size.x / 2
	$PerdisteLabel.position.y = screen_size.y / 2 - $PerdisteLabel.size.y / 2
	$PerdisteLabel.visible = true
