extends PNJState

@export var min_wait := 3.0
@export var max_wait := 4.0

var _idling_time := 0.0
var _idle_timer:float = 0
	
func enter(msg: = {}) -> void:
	owner.modulate = Color.GREEN
	_idling_time = randf_range(min_wait, max_wait)
	_idle_timer = 0
		
func physics_process(delta):
	_idle_timer += delta
	if owner is Flic:
		if owner.line_of_sight.player_is_in_sight():
			_state_machine.transition_to("Chasing")
			return
	
		if owner.laughing_detector.has_overlapping_areas():
			_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
			return
		
	if _idle_timer > _idling_time:
		_state_machine.transition_to("Wandering")
		return
	



