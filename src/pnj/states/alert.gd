extends PNJState

const ALERT_TIME:float = 0.5

@export var _time_before_chasing := 0.0

var _player_last_seen_position: Vector2

func enter(msg: = {}) -> void:
	if owner is Flic:
		owner.line_of_sight.set_LOS_color(owner.chase_line_of_sight_color)
	_player_last_seen_position = msg[Const.PLAYER_LAST_POSITION]
	_time_before_chasing = ALERT_TIME
	owner.line_of_sight.look_at(_player_last_seen_position)
	owner.line_of_sight.rotation -= deg_to_rad(90)
	owner.skin.play("alert")
	owner.show_reaction(Const.REACTION_ALERT)
	
func exit(msg: = {}) -> void:
	owner.hide_reaction()
	
func process(delta):
	_time_before_chasing -= delta
	if _time_before_chasing <= 0.0:
		_state_machine.transition_to("Chasing", {Const.PLAYER_LAST_POSITION: _player_last_seen_position})
		return
