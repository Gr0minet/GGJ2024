extends CanvasLayer
class_name EndMenuCanvas

@export var end_result_label:Label = null
@export var button_return_menu:Button = null

@export var main_menu_scene:PackedScene = null

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


func display() -> void:
	print("ok")
