@tool
class_name PresetSettings
extends VBoxContainer


signal preset_settings_done()

const FREE_OR_GRID_RENDERERS = {
	&"2DIsometric": "2D isometric",
	&"2DTopDown": "2D top-down",
	&"3DIsometric": "3D isometric",
	&"3DTopDown": "3D top-down"
}

@onready var _label: Label = $Label


func _on_confirmed_renderers(_primary_renderer: StringName, renderers: Array[StringName]) -> void:
	var selected_free_or_grid_renderers: Array[StringName] = renderers.filter(func (renderer): return FREE_OR_GRID_RENDERERS.has(renderer))
	
	if selected_free_or_grid_renderers.is_empty():
		preset_settings_done.emit()
		return
	visible = true
	
	var selected_size := selected_free_or_grid_renderers.size()
	for i: int in range(selected_size):
		var renderer: StringName = selected_free_or_grid_renderers[i]
		
		var display := CheckButtonDisplay.new(renderer, FREE_OR_GRID_RENDERERS[renderer])
		_label.add_sibling(display)
		
		if i < selected_size - 1:
			var new_separator := HSeparator.new()
			display.add_sibling(new_separator)


func _on_confirm_pressed() -> void:
	visible = false
	preset_settings_done.emit()
