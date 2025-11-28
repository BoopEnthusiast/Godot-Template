class_name UIManager
extends CanvasLayer


enum AnimationType {
	NONE,
	FADE,
	SLIDE,
}

@export var animation_type: AnimationType = AnimationType.FADE
@export_range(0.01, 2.0) var animation_length: float = 1.0

@onready var _main_menu: MainMenu = $MainMenu
@onready var _new_game: Control = $NewGame
@onready var _load_game: Control = $LoadGame
@onready var _settings: Control = $Settings


func _animate_between(from: Control, to: Control, reverse: bool = false) -> void:
	match animation_type:
		AnimationType.NONE:
			from.visible = false
			if is_instance_valid(to):
				to.visible = true
		AnimationType.FADE:
			# Prep from and to
			from.visible = true
			if is_instance_valid(to):
				to.modulate = Color.TRANSPARENT
				to.visible = true
			# Animate the `from` going to transparent and `to` becoming clear
			var tween := create_tween()
			tween.tween_property(from, ^"modulate", Color.TRANSPARENT, animation_length)
			if is_instance_valid(to):
				tween.parallel().tween_property(to, ^"modulate", Color.WHITE, animation_length)
			# Reset modulate after it's done to avoid mess-ups with the animation_type changing or whatever
			tween.tween_property(from, ^"visible", false, 0.0)
			tween.tween_property(from, ^"modulate", Color.WHITE, 0.0)
		AnimationType.SLIDE:
			# Setup reverse slide animation
			var from_movement: float = from.offset_right + from.size.x
			var to_position: float = 0
			if is_instance_valid(to):
				to_position = to.offset_right + to.size.x
			if reverse:
				from_movement *= -1
				to_position *= -1
			
			# Prep from and to
			from.visible = true
			if is_instance_valid(to):
				to.position.x = to_position
				to.visible = true
			# Animate the `from` going to transparent and `to` becoming clear
			var tween := create_tween()
			tween.tween_property(from, ^"position", Vector2(from_movement, from.position.y), animation_length)
			if is_instance_valid(to):
				tween.parallel().tween_property(to, ^"position", Vector2(0.0, to.position.y), animation_length)
			# Reset offset after it's done to avoid mess-ups with the animation_type changing or whatever
			tween.tween_property(from, ^"visible", false, 0.0)
			tween.tween_property(from, ^"position", Vector2.ZERO, 0.0)


func _on_continue_pressed(source: Control) -> void:
	_animate_between(source, null)


func _on_load_game_pressed(source: Control) -> void:
	_animate_between(source, _load_game)


func _on_new_game_pressed(source: Control) -> void:
	_animate_between(source, _new_game)


func _on_settings_pressed(source: Control) -> void:
	_animate_between(source, _settings)

func _on_return_to_main_menu(source: Control) -> void:
	_animate_between(source, _main_menu, true)
