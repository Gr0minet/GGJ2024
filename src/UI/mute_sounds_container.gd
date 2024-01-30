extends MarginContainer

@export var mute_se_button:TextureButton = null
@export var mute_bgm_button:TextureButton = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if mute_se_button == null:
		push_error("No mute sound effects button found in %s" % self)
		return
	
	if mute_bgm_button == null:
		push_error("No mute background music button found in %s" % self)
		return

	mute_se_button.toggled.connect(_on_mute_se_button_toggled)
	mute_se_button.set_pressed_no_signal(PlayerSettings.se_muted)
	
	mute_bgm_button.toggled.connect(_on_mute_bgm_button_toggled)
	mute_bgm_button.set_pressed_no_signal(PlayerSettings.bgm_muted)
	
	# Load player settings
	_on_mute_bgm_button_toggled(PlayerSettings.bgm_muted)
	_on_mute_se_button_toggled(PlayerSettings.se_muted)



func _on_mute_se_button_toggled(toggled_on:bool):
	MusicManager.mute_sound_effects(toggled_on)
	PlayerSettings.se_muted = toggled_on

func _on_mute_bgm_button_toggled(toggled_on:bool):
	MusicManager.mute_background_music(toggled_on)
	PlayerSettings.bgm_muted = toggled_on
