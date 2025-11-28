@tool
class_name PresetSelector
extends CheckBox


signal set_primary(preset: StringName, selector: PresetSelector)

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
		print("Primary visible:")
		print(_set_primary.visible)
		is_primary = value

var _set_primary: Button


func _ready() -> void:
	# Clear the children
	for child: Node in get_children(true):
		child.queue_free()
	print("removed children")
	await get_tree().create_timer(1.0).timeout
	print("Things")
	
	# If there's no primary button already
	if get_child_count(true) == 1 and _set_primary == get_child(0, true):
		return
	
	# Clear the children
	for child: Node in get_children(true):
		child.queue_free()
	
	# Make one :3
	_make_new_set_primary_button()


#func _process(_delta: float) -> void:
	#_set_primary.set_anchors_preset(Control.PRESET_RIGHT_WIDE)
	#if get_tree().get_frame() % 60 == 0: 
		#print(size,"\t\t",_set_primary.position,"\t\t",_set_primary.size)


func _on_set_primary_pressed() -> void:
	set_primary.emit(text, self)
	is_primary = true


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_set_primary.visible = not is_primary
	else:
		_set_primary.visible = false


func _make_new_set_primary_button() -> void:
	_set_primary = Button.new()
	
	add_child(_set_primary, false)
	
	_set_primary.text = "Set primary"
	_set_primary.set_anchors_and_offsets_preset(Control.PRESET_RIGHT_WIDE, Control.PRESET_MODE_KEEP_SIZE)
	_set_primary.set_anchors_and_offsets_preset(Control.PRESET_RIGHT_WIDE, Control.PRESET_MODE_KEEP_SIZE)
	#set_primary_button.visible = false
	_set_primary.pressed.connect(_on_set_primary_pressed)
	print(_set_primary.position,"\t",_set_primary.size)
