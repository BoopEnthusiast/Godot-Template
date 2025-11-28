@tool
class_name Renderers
extends VBoxContainer


signal confirmed_renderers(primary_renderer: StringName, renderers: Array[StringName])


@onready var _renderer_selector: RendererSelector = $Renderers/RendererSelector
@onready var _confirm: Button = $Confirm


func _on_renderer_selector_primary_selected() -> void:
	_confirm.disabled = false


func _on_renderer_selector_primary_deselected() -> void:
	_confirm.disabled = true


func _on_confirm_pressed() -> void:
	visible = false
	confirmed_renderers.emit(_renderer_selector.primary_preset.get_preset_name(), _renderer_selector.get_selected_renderers())
