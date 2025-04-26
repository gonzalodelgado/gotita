extends RigidBody2D

var dir = 1
var min_speed = 64
enum Estados {LIQUIDO, GASEOSO, SOLIDO}
var estado: Estados = Estados.SOLIDO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match estado:
		Estados.LIQUIDO:
			physics_material_override.friction = 0.15
			physics_material_override.absorbent = true
			physics_material_override.bounce = 0
			physics_material_override.rough = false
			mass = 0.035
			min_speed = 64
		Estados.SOLIDO:
			physics_material_override.friction = 0.01
			physics_material_override.bounce = 0.2
			physics_material_override.absorbent = true
			physics_material_override.rough = true
			mass = 0.035
			min_speed = 128
		Estados.GASEOSO:
			physics_material_override.friction = 0
			physics_material_override.bounce = 0.1
			physics_material_override.rough = false
			mass = -0.035
			min_speed = 32
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
