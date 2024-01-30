extends Node
# Class managing save and load of player settings
# For instance, the mute state of BGM and SE.

const AUDIO_CATEGORY:String = "audio"
const BGM_MUTED_OPTION:String = "bgm_muted"
const SE_MUTED_OPTION:String = "se_muted"

var config:ConfigFile = null

## Config options
var bgm_muted:bool = false :
	get:
		return bgm_muted
	set(value):
		bgm_muted = value
		config.set_value(AUDIO_CATEGORY, BGM_MUTED_OPTION, bgm_muted)
		save_config()

var se_muted:bool = false :
	get:
		return se_muted
	set(value):
		se_muted = value
		config.set_value(AUDIO_CATEGORY, SE_MUTED_OPTION, se_muted)
		save_config()

var _default_config_name:String = "config.cfg"

# Called when the node enters the scene tree for the first time.
func _ready():
	if not load_config(_default_config_name):
		create_config(_default_config_name)

	# Init config options
	bgm_muted = config.get_value(AUDIO_CATEGORY, BGM_MUTED_OPTION, bgm_muted)
	se_muted = config.get_value(AUDIO_CATEGORY, SE_MUTED_OPTION, se_muted)

func get_config_path(config_name:String) -> String:
	return "user://%s" % config_name

# Load the config file from the user:// folder
# Returns true if loading was successful, false otherwise
func load_config(config_name:String) -> bool:
	var new_config:ConfigFile = ConfigFile.new()

	var err = new_config.load(get_config_path(config_name))
	if err != OK:
		push_error("Error loading config file '%s': %s" % [config_name, err])
		return false
	else:
		config = new_config
		return true

# Create a new config file with default values
func create_config(config_name:String) -> void:
	config = ConfigFile.new()
	config.set_value(AUDIO_CATEGORY, BGM_MUTED_OPTION, bgm_muted)
	config.set_value(AUDIO_CATEGORY, SE_MUTED_OPTION, se_muted)

	var err = config.save(get_config_path(config_name))

	if err != OK:
		push_error("Error creating config file '%s': %s" % [config_name, err])
		return
	

# Save the config file to the user:// folder
func save_config(config_name:String="") -> void:
	if config_name == "":
		config_name = _default_config_name
	print("saving config to %s" % get_config_path(config_name))
	print(config)

	var err = config.save(get_config_path(config_name))
	if err != OK:
		push_error("Error saving config file '%s': %s" % [config_name, err])
		return
