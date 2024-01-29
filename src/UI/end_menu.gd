extends CanvasLayer
class_name EndMenuCanvas

@export var end_result_label:Label = null
@export var button_return_menu:Button = null

@export var main_menu_scene:PackedScene = null
@export var win_lose_frame:TextureRect = null

@export var win_image:Texture
@export var lose_image:Texture

var won:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	button_return_menu.pressed.connect(func():
		get_tree().paused = false
		get_tree().change_scene_to_packed(main_menu_scene)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_end_result_label(text:String) -> void:
	end_result_label.text = text
	
func set_win() -> void:
	end_result_label.text = "You win :)"
	win_lose_frame.texture = win_image
	won = true

func set_lose() -> void:
	end_result_label.text = "You lose :("
	win_lose_frame.texture = lose_image
	won = false

func display() -> void:
	pass # do not delete, just in case
	
func play_end_music():
	print("play end music")
	MusicManager.StopMusic()
	if won:
		MusicManager.play_sound_effect(SoundBank.win)
	else:
		MusicManager.play_sound_effect(SoundBank.lose)
