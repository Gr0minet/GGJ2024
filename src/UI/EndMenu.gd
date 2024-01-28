extends CanvasLayer
class_name EndMenuCanvas

@export var end_result_label:Label = null
@export var button_return_menu:Button = null

@export var main_menu_scene:PackedScene = null
@export var win_lose_frame:TextureRect = null

@export var win_image:Texture
@export var lose_image:Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	button_return_menu.pressed.connect(func():
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

func set_lose() -> void:
	end_result_label.text = "You lose :("
	win_lose_frame.texture = lose_image

func display() -> void:
	print("ok")
