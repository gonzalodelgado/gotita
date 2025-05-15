extends StaticBody2D

@onready var coll_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@export var max_gotitas = 10
@export var gotitas_objetivo = 8
@export var gotita_scene: PackedScene
@export_enum("LIQUIDO", "GASEOSO", "SOLIDO") var estado_inicial: String
var gotitas_generadas = 0
var gotitas_salvadas = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GanasteLabel.visible = false
	polygon_2d.polygon = coll_polygon_2d.polygon
	polygon_2d.offset = coll_polygon_2d.position
	gotitas_generadas = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gotitas_salvadas >= gotitas_objetivo:
		var screen_size = get_viewport_rect().size
		$GanasteLabel.position.x = screen_size.x / 2 - $GanasteLabel.size.x / 2
		$GanasteLabel.position.y = screen_size.y / 2 - $GanasteLabel.size.y / 2
		$GanasteLabel.visible = true

func _on_timer_gotita_timeout() -> void:
	# var cantidad_gotitas = get_children().filter(func(child): return child.scene_file_path == gotita_scene.resource_path).size()
	if gotitas_generadas < max_gotitas:
		var gotita = gotita_scene.instantiate()
		gotita.cambiar_estado(estado_inicial)
		gotita.position.x = 10
		add_child(gotita)
		gotitas_generadas += 1


func _on_objetivo_body_entered(body:Node2D) -> void:
	if body.scene_file_path == gotita_scene.resource_path:
		print("BODY entro objetivo", body)
		body.queue_free()
		gotitas_salvadas += 1
