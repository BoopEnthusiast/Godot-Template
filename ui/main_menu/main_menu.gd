class_name MainMenu
extends Control


signal continue_pressed(source: MainMenu)
signal new_game_pressed(source: MainMenu)
signal load_game_pressed(source: MainMenu)
signal settings_pressed(source: MainMenu)

@onready var _continue: HBoxContainer = $MenuButtons/Continue
@onready var _continue_last_save_label: Label = $MenuButtons/Continue/LastSave

@onready var _continue_button: Button = $MenuButtons/Continue/ContinueButton
@onready var _new_game: Button = $MenuButtons/NewGame
@onready var _load_game: Button = $MenuButtons/LoadGame
@onready var _settings: Button = $MenuButtons/Settings


func _ready() -> void:
	# Connect button pressed signals, which aren't already connected, to emit this node's signals
	_continue_button.pressed.connect(continue_pressed.emit.bind(self))
	_new_game.pressed.connect(new_game_pressed.emit.bind(self))
	_load_game.pressed.connect(load_game_pressed.emit.bind(self))
	_settings.pressed.connect(settings_pressed.emit.bind(self))
	
	# By default, the continue button (which loads the last save) is hidden unless there is a save to continue
	_update_continue()


func _update_continue() -> void:
	if not Saves.has_last_saved_game():
		return
	_continue.visible = true
	_continue_last_save_label.text = "" # TODO: Display the date/time it was saved and the time since then 
