extends PNJWanderingState
	
func _ready():
	super()
	_default_state_after_wandering = "LookingAround"

func enter(msg: = {}) -> void:
	super(msg)
	owner.line_of_sight.set_LOS_color(owner.normal_line_of_sight_color)
	owner.line_of_sight.look_at(owner.line_of_sight.global_position + _direction)
	owner.line_of_sight.rotation += rad_to_deg(90)
	
func physics_process(_delta: float) -> void:
	super(_delta)
	if owner.line_of_sight.player_is_in_sight():
		var position = owner.line_of_sight.get_player_in_sight().position
		_state_machine.transition_to("Alert", {Const.PLAYER_LAST_POSITION: position})
		return
	if owner.laughing_detector.has_overlapping_areas():
		_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
		return
