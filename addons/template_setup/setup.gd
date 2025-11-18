@tool
extends EditorPlugin


const _SETUP_WINDOW = preload("uid://cfeygiorcdosn")

var _template_storage: TemplateStorage = preload("uid://dujyyoo1nruww")


func _ready() -> void:
	var setup_window: Window = _SETUP_WINDOW.instantiate()
	EditorInterface.popup_dialog_centered_clamped(setup_window)
	_template_storage.setup_window = setup_window
