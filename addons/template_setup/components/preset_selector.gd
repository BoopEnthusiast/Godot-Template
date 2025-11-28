@tool
class_name PresetSelector
extends CheckBox


signal set_primary(selector: PresetSelector)
signal toggled_off(selector: PresetSelector)


var _set_primary: Button


func _ready() -> void:
	toggled.connect(_on_toggled)
	
	# If there's no primary button already
	if get_child_count(true) == 1 and _set_primary == get_child(0, true):
		return
	
	# Clear the children
	for child: Node in get_children(true):
		child.queue_free()
	
	# Make one :3
	_make_new_set_primary_button()


func not_primary_anymore() -> void:
	_set_primary.visible = true
	_set_primary.disabled = false
	_set_primary.text = "Set primary"


func _on_set_primary_pressed() -> void:
	_set_primary.disabled = true
	_set_primary.text = "Primary"
	set_primary.emit(self)


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_set_primary.visible = true
	else:
		toggled_off.emit(self)
		_set_primary.visible = false
		_set_primary.disabled = false
		_set_primary.text = "Set primary"


func _make_new_set_primary_button() -> void:
	_set_primary = Button.new()
	
	add_child(_set_primary, false, Node.INTERNAL_MODE_FRONT)
	
	_set_primary.text = "Set primary"
	_set_primary.set_anchors_and_offsets_preset(Control.PRESET_RIGHT_WIDE, Control.PRESET_MODE_KEEP_SIZE)
	_set_primary.set_anchors_and_offsets_preset(Control.PRESET_RIGHT_WIDE, Control.PRESET_MODE_KEEP_SIZE)
	_set_primary.visible = false
	
	_set_primary.pressed.connect(_on_set_primary_pressed)
