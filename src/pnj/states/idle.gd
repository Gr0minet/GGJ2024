extends PNJState

@export var min_wait := 3.0
@export var max_wait := 4.0

@export var stun_time:float = 1.5

var _idling_time := 0.0
var _idle_timer:float = 0

var stunned:bool = false
	
func enter(msg: = {}) -> void:
	stunned = false
	owner.velocity = Vector2.ZERO
	owner.modulate = Color.GREEN
	_idling_time = randf_range(min_wait, max_wait)
	_idle_timer = 0
	
	if Const.MSG_REASON in msg and msg[Const.MSG_REASON] == "poop":
		owner.modulate = Color.RED
		stunned = true
		_idling_time = stun_time
		
func physics_process(delta):
	_idle_timer += delta
	if owner is Flic and not stunned:
		if owner.line_of_sight.player_is_in_sight():
			_state_machine.transition_to("Chasing")
			return
	
		if owner.laughing_detector.has_overlapping_areas():
			_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
			return
		
	if _idle_timer > _idling_time:
		if stunned:
			stunned = false
		else:
			_state_machine.transition_to("Wandering")
			return
