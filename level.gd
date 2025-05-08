extends StaticBody2D

@onready var coll_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	polygon_2d.polygon = coll_polygon_2d.polygon
	polygon_2d.offset = coll_polygon_2d.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
