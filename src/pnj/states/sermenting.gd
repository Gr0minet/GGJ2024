extends PNJState

@export var sermenting_duration:float = 2.0;
@export var progress_bar_position:Marker2D = null
@export var progress_bar_scene:PackedScene = null


var _target:Node2D = null

var _sermenting_timer:float = 0.0
var _progress_bar:Node2D = null

func enter(msg: = {}) -> void:
	owner.skin.play("sermenting")
	owner.show_reaction(Const.REACTION_SERMENTING)
	_sermenting_timer = 0.0
	_target = msg["target"]
	
	if _target == null:
		push_error("Entered Sermenting state with no target in %s" % [owner])
	
	if progress_bar_position == null:
		push_error("Progress bar is null in pooping")
		return
	if progress_bar_scene == null:
		push_error("Progress bar scene is null is pooping")
		return
	
	_progress_bar = progress_bar_scene.instantiate()
	_progress_bar.set_max_value(sermenting_duration)
	_progress_bar.show_text_progress(true)
	progress_bar_position.add_child(_progress_bar)
	
func physics_process(delta) -> void:
	if owner.line_of_sight.player_is_in_sight():
		var position = owner.line_of_sight.get_player_in_sight().position
		_state_machine.transition_to("Alert", {Const.PLAYER_LAST_POSITION: position})
		return
	
	_sermenting_timer += delta
	_progress_bar.set_value(_sermenting_timer)
	
	if _sermenting_timer >= sermenting_duration:
		_target.stop_laughing()
		_state_machine.transition_to("LookingAround")
		return
	
func exit(msg: = {}) -> void:
	print("end sermenting")
	owner.hide_reaction()
	if _progress_bar:
		_progress_bar.queue_free()
