extends RigidBody2D

var dir = 1
var min_speed = 64

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var size = $CollisionShape2D.shape.radius
	if position.x - size <= 0:
		position.x = size + 1
		dir = 1
		linear_velocity.x = min_speed * dir
	elif position.x + size >= get_viewport_rect().size.x:
		position.x = get_viewport_rect().size.x - size - 1
		dir = -1
		linear_velocity.x = min_speed * dir
	if abs(linear_velocity.x) < min_speed:
		linear_velocity.x = min_speed * dir

