extends Control

@export var button_play:Button = null
@export var button_credits:Button = null
@export var button_quit:Button = null

@export var game_scene:PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	button_play.pressed.connect(func():
		get_tree().change_scene_to_packed(game_scene)
	)
	
	button_credits.pressed.connect(func():
		pass
	)
	
	# remove quit button if Web (not needed)
	if OS.get_name() == "Web":
		button_quit.queue_free()
	else:
		button_quit.pressed.connect(func():
			get_tree().quit()
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
