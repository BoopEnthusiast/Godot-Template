@tool
class_name ShowSetupWindow
extends EditorScript

var _template_storage: TemplateStorage = preload("uid://dujyyoo1nruww")

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	_template_storage.setup_window.show()
	_template_storage.setup_window.process_mode = Node.PROCESS_MODE_INHERIT
