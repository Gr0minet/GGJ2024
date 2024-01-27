extends PlayerState

@export var poop_duration:float = 1.0;
@export var progress_bar_position:Marker2D = null
@export var progress_bar_scene:PackedScene = null

var _poop_timer:float = 0.0
var _progress_bar:Node2D = null

func unhandled_input(event: InputEvent) -> void:
	pass
	
func process(delta: float) -> void:
	if Input.is_action_just_released(Const.INPUT_POOP):
		_state_machine.transition_to("Move")
	elif Input.is_action_pressed(Const.INPUT_POOP):
		_poop_timer += delta;
		print(_poop_timer)
		_progress_bar.set_value(_poop_timer)
	
	if _poop_timer >= poop_duration:
		player.pooped.emit()
		_state_machine.transition_to("Move")

func physics_process(delta: float) -> void:
	pass

func enter(msg: = {}) -> void:
	_poop_timer = 0.0
	print("POOPING")
	
	if progress_bar_position == null:
		push_error("Progress bar is null in pooping")
		return
	if progress_bar_scene == null:
		push_error("Progress bar scene is null is pooping")
		return
	
	_progress_bar = progress_bar_scene.instantiate()
	_progress_bar.set_max_value(poop_duration)
	_progress_bar.show_text_progress(true)
	progress_bar_position.add_child(_progress_bar)
	
	
	
func exit(msg: = {}) -> void:
	if _progress_bar:
		_progress_bar.queue_free()
