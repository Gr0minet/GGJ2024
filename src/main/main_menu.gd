extends Control

@export var button_play:TextureButton = null
@export var button_credits:TextureButton = null
@export var button_quit:TextureButton = null
@export var button_quit_credit:TextureButton = null
@export var credit_panel:PanelContainer = null
@export_file("*.tscn","*.scn") var game_scene_path:String

@export var main_menu_music:AudioStream = null

# Called when the node enters the scene tree for the first time.
func _ready():
	button_play.pressed.connect(func():
		get_tree().change_scene_to_file(game_scene_path)
	)
	
	button_credits.pressed.connect(func():
		credit_panel.show()
	)
	
	button_quit_credit.pressed.connect(_on_quit_credit)
	
	# remove quit button if Web (not needed)
	if OS.get_name() == "Web":
		button_quit.queue_free()
	else:
		button_quit.pressed.connect(func():
			get_tree().quit()
		)
		
	MusicManager.play_music(main_menu_music)
	
	button_play.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("start_controller"):
		get_tree().change_scene_to_file.call_deferred(game_scene_path)

func _on_quit_credit() -> void:
	credit_panel.hide()
