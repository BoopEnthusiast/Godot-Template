@tool
class_name PresetSelector
extends CheckBox


signal set_primary(preset: StringName)

var is_primary: bool = false:
	set(value):
		if not is_node_ready():
			await ready
		if value:
			_set_primary.visible = false
		elif button_pressed:
			_set_primary.visible = true
		else:
			_set_primary.visible = false
		is_primary = value

var _set_primary: Button


func _enter_tree() -> void:
	var set_primary_button := Button.new()
	_set_primary = set_primary_button
	set_primary_button.set_anchors_preset(Control.PRESET_RIGHT_WIDE)
	add_child(set_primary_button, false, Node.INTERNAL_MODE_FRONT)


func _on_set_primary_pressed() -> void:
	set_primary.emit(text)


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_set_primary.visible = not is_primary
	else:
		_set_primary.visible = false
