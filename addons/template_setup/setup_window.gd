@tool
extends Window


func _on_close_requested() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	print(get_path())


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == Key.KEY_ESCAPE:
			_on_close_requested()
