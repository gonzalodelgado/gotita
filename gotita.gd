extends RigidBody2D

var dir = 1
var min_speed = 64
enum Estados {LIQUIDO, GASEOSO, SOLIDO}
var estado: Estados = Estados.LIQUIDO
var gravity : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var screen_size
signal murio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var size = $CollisionShape2D.shape.radius

	if abs(linear_velocity.x) < min_speed:
		linear_velocity.x = min_speed * dir

	if position.x - size <= 0:
		dir = 1
		linear_velocity.x = min_speed * dir
	elif position.x + size >= screen_size.x:
		dir = -1
		linear_velocity.x = min_speed * dir
	position.x = clamp(position.x, 0, screen_size.x)
	if position.y + size > screen_size.y:
		murio.emit()
		queue_free()
	position.y = clamp(position.y, 0, screen_size.y)


func _integrate_forces(state: PhysicsDirectBodyState2D):
	var size = $CollisionShape2D.shape.radius
	if position.y - size <= 2:
		position.y = size + 3

	if estado != Estados.GASEOSO and position.y - size <= 2:
		state.apply_impulse(gravity*2)


func cambiar_estado(estado_str: String):
	var nuevo_estado = Estados.get(estado_str)
	if estado == nuevo_estado:
		return
	estado = nuevo_estado

	match estado:
		Estados.LIQUIDO:
			physics_material_override.friction = 0.15
			physics_material_override.absorbent = true
			physics_material_override.bounce = 0
			min_speed = 64
			gravity_scale = 1.8
			set_collision_mask_value(1, false)
			$Label.text = "💧"
			$"Bubbly FX".play()
		Estados.SOLIDO:
			physics_material_override.friction = 0.01
			physics_material_override.bounce = 0.2
			physics_material_override.absorbent = true
			min_speed = 128
			gravity_scale = 2.5
			set_collision_mask_value(1, true)
			$Label.text = "🧊"
			$"Icy FX".play()
		Estados.GASEOSO:
			physics_material_override.friction = 0
			physics_material_override.bounce = 0.1
			min_speed = 32
			gravity_scale = -0.4
			set_collision_mask_value(1, false)
			$Label.text = "☁"
			$"Cloudy FX".play()
