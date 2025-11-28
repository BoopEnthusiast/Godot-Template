@tool
class_name RendererSelector
extends VBoxContainer


signal primary_deselected()
signal primary_selected()

@onready var presets: Array[PresetSelector] = [$"2D/VBoxContainer/Isometric", $"2D/VBoxContainer/SideOn", $"2D/VBoxContainer/TopDown", $"3D/VBoxContainer/FirstPerson", $"3D/VBoxContainer/Isometric", $"3D/VBoxContainer/SideOn", $"3D/VBoxContainer/ThirdPerson", $"3D/VBoxContainer/TopDown", $UI/VBoxContainer/Empty, $UI/VBoxContainer/Drag]

var primary_preset: PresetSelector


func _ready() -> void:
	for preset: PresetSelector in presets:
		preset.set_primary.connect(_on_primary_selected)
		preset.toggled_off.connect(_on_selector_toggled_off)


func get_selected_renderers() -> Array[StringName]:
	var selected_presets: Array[StringName]
	for preset: PresetSelector in presets:
		if preset.button_pressed:
			selected_presets.append(preset.name)
	return selected_presets


func _on_primary_selected(selector: PresetSelector) -> void:
	if primary_preset != null:
		primary_preset.not_primary_anymore()
	primary_preset = selector
	primary_selected.emit()


func _on_selector_toggled_off(selector: PresetSelector) -> void:
	if selector == primary_preset:
		primary_preset = null
		primary_deselected.emit()
