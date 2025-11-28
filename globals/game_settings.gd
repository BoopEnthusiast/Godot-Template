extends Node
## Holds the game-wide user settings. 


## The location the [member config_file] is stored at.
const CONFIG_FILE_LOCATION = "user://settings.cfg"

const _VIDEO_SECTION = "video"
const _GAME_SECTION = "game"

## The [ConfigFile] all of the settings are stored in.
var config_file: ConfigFile = ConfigFile.new()

# These are used to just cut down how many characters are used to make things a bit less painful to write and look at
# they're used by the private methods at the bottom of the script
var _active_section: String
var _active_object: Object


func _enter_tree() -> void:
	load_config_file()


## Loads in the settings [member config_file].
func load_config_file() -> void:
	var err = config_file.load(CONFIG_FILE_LOCATION)
	if err != OK:
		return
	
	if config_file.has_section(_GAME_SECTION):
		_active_section = _GAME_SECTION
		
		# It's here you should add your own game's settings. You'll have to add UI for them, too
	
	if config_file.has_section(_VIDEO_SECTION):
		_active_section = _VIDEO_SECTION
		
		_active_object = get_viewport()
		_a("anisotropic_filtering_level")
		_a("fsr_sharpness")
		_a("msaa_2d")
		_a("msaa_3d")
		_a("screen_space_aa")
		_a("scaling_3d_mode")
		_a("scaling_3d_scale")
		_a("use_hdr_2d")
		_a("use_taa")
		
		var window := get_window()
		window.mode = _g("window_mode", window.mode) # Just calling it "mode" is a little odd


## Save the current settings to [member config_file].
func save_settings() -> void:
	config_file.save(CONFIG_FILE_LOCATION)


# Used to just cut down how many characters are used to make things a bit less painful to write and to look at
# g stands for get, as in get the value of this thing, and then return the value you should set to it
func _g(stored_key: String, value_to_change: Variant) -> Variant:
	return config_file.get_value(_active_section, stored_key, value_to_change)
# p stands for property, to set a property on an object
func _p(object: Object, property_and_key: String) -> void:
	object.set(property_and_key, config_file.get_value(_active_section, property_and_key, object.get(property_and_key)))
# a stands for active, to set a property on the actively selected object
func _a(property_and_key: String) -> void:
	_active_object.set(property_and_key, config_file.get_value(_active_section, property_and_key, _active_object.get(property_and_key)))
