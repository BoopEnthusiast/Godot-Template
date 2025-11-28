@tool
class_name PresetTypes
extends SetupPageBase


@onready var free_or_grid_renderers: Dictionary[StringName, Node] = {
	&"2DIsometric": $"Contents/ContentList/2DIsometric",
	&"2DTopDown": $"Contents/ContentList/2DTopDown",
	&"3DIsometric": $"Contents/ContentList/3DIsometric",
	&"3DTopDown": $"Contents/ContentList/3DTopDown",
}

func _on_confirmed_renderers(_primary_renderer: StringName, renderers: Array[StringName]) -> void:
	var selected_free_or_grid_renderers: Array[StringName] = renderers.filter(func (renderer): return free_or_grid_renderers.has(renderer))
	
	if selected_free_or_grid_renderers.is_empty():
		confirm.emit()
		return
	visible = true
	
	for selected: StringName in selected_free_or_grid_renderers:
		free_or_grid_renderers[selected].visible = true
