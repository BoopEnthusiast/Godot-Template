@tool @abstract
class_name SetupPageBase
extends VBoxContainer


signal go_back()
signal confirm()

@export var previous: SetupPageBase
@export var next: SetupPageBase

@onready var _label: Label = $Label
@onready var _back: Button = $ConfirmBack/Back
@onready var _confirm: Button = $ConfirmBack/Confirm


func _on_confirm_pressed() -> void:
	visible = false
	if is_instance_valid(next):
		next.visible = true
	confirm.emit()


func _on_back_pressed() -> void:
	if is_instance_valid(previous):
		visible = false
		previous.visible = true
	go_back.emit()
