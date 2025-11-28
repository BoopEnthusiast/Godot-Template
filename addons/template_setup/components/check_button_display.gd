class_name CheckButtonDisplay
extends HBoxContainer


signal toggled(free_or_grid: bool)

var _preset_name: StringName
var _text: String

@onready var _label: Label
@onready var _check_button: CheckButton


func _init(preset_name: StringName, text: String) -> void:
	_preset_name = preset_name
	_text = text


func _ready() -> void:
	# If there's no primary button already
	if get_child_count(true) > 0:
		return
	
	# Clear the children
	for child: Node in get_children(true):
		child.queue_free()
	
	# Make one :3
	_make_new_children()


func _make_new_children() -> void:
	_label = Label.new()
	_check_button = CheckButton.new()
	
	add_child(_label, false, Node.INTERNAL_MODE_FRONT)
	add_child(_check_button, false, Node.INTERNAL_MODE_FRONT)
	
	_label.text = _text
	_check_button.text = "Free"
