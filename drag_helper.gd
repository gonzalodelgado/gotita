extends RefCounted

const MIN_DIST = 96
const VALID_DIST = 64
static var start_pos: Vector2

static func handle_input_for_drag(event, node):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.position - node.position).length() < node.get_drag_radius():
			if not node.dragging and event.pressed:
				start_pos = Vector2(event.position)
				if "start_drag" in node:
					node.start_drag()
				node.dragging = true
		if node.dragging:
			if not event.pressed:
				# Stop dragging if the button is released.
				var dist = (start_pos - event.position).length()
				if dist > MIN_DIST:
					if "drop" in node:
						node.drop()
				else:
					if "cancel_drag" in node:
						node.cancel_drag()
				node.dragging = false


	if event is InputEventMouseMotion and node.dragging:
		node.get_drag_obj().position = event.position
		var dist = (start_pos - event.position).length()
		if dist > VALID_DIST and "drag_validated" in node:
			node.drag_validated()
