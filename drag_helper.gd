extends RefCounted

static func handle_input_for_drag(event, node):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.position - node.position).length() < node.get_drag_radius():
			if not node.dragging and event.pressed:
				if "start_drag" in node:
					node.start_drag()
				node.dragging = true
		# Stop dragging if the button is released.
		if node.dragging and not event.pressed:
			if "drop" in node:
				node.drop()
			node.dragging = false

	if event is InputEventMouseMotion and node.dragging:
		node.get_drag_obj().position = event.position
