extends Node
## Singleton for handling saves.
##
## Each game is stored as a directory containing all the different
## backup [ConfigFile]s of that game, including the most recent one.


## This is stored as [code]{"Name of saved game": [Array, of, associated, ConfigFiles, sorted, by, recency]}[/code].[br]
## [br]
## Each game is stored as a directory by the same name as the [String] located under [code]user://saves[/code].
## Each directory contains all of the saves for that game as [ConfigFile]s named by when they were saved.
var save_games: Dictionary[String, Array]
## The most recent save.[br]
## [br]
## This is a reference to the same [ConfigFile] used in [member save_games].
var last_save: ConfigFile


func _enter_tree() -> void:
	refresh_saved_games()


## Refereshes [member save_games].[br]
## [br]
## If [param light] is [code]true[/code], it means this method will only search for the games and not the associated saves.
## This leads to the values of the [member save_games] dictionary being empty but should be slightly faster if there are a [i]lot[/i] of saves.
func refresh_saved_games(light: bool = false) -> void:
	if not DirAccess.dir_exists_absolute("user://saves"):
		var err := DirAccess.make_dir_absolute("user://saves")
		assert(err == OK, "Could not make saves directory to store saved games in")
	
	# Open the user saves folder
	var save_dir := DirAccess.open("user://saves")
	assert(is_instance_valid(save_dir), "user://saves could not be opened")
	
	# Clear the currently loaded set of save games
	save_games.clear()
	
	# Get save game directories
	var save_directories := save_dir.get_directories()
	if save_directories.is_empty():
		return
	
	# Load each saved game and its saves
	for directory: String in save_directories:
		# Only gets the game names if light is enabled
		if light:
			save_games[directory] = []
			continue
		
		# Open the new game save directory
		var dir := DirAccess.open("user://saves" + directory)
		if not is_instance_valid(dir):
			continue
		
		# TODO: Sort by recency (either here or later)
		# Load in the saves for this game
		var saves := dir.get_files()
		for save: String in saves:
			# Make the ConfigFile of this save
			var new_config_file := ConfigFile.new()
			if new_config_file.load("user://saves/" + directory + "/" + save) != OK:
				continue
			
			# Add the ConfigFile to save_games under the game/directory name
			if save_games.has(directory):
				save_games[directory].append(new_config_file)
			else:
				save_games[directory] = [new_config_file]
			
			# TODO: Set the last saved game


## Checks if [member last_save] has been set. You may need to [method refresh_saved_games].
func has_last_saved_game() -> bool:
	if is_instance_valid(last_save):
		return true
	return false
