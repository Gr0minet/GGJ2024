extends PNJState

const ALERT_TIME:float = 0.5

@export var _time_before_chasing := 0.0

var _player_last_seen_position: Vector2

func enter(msg: = {}) -> void:
	_player_last_seen_position = msg[Const.PLAYER_LAST_POSITION]
	_time_before_chasing = ALERT_TIME
	owner.line_of_sight.look_at(_player_last_seen_position)
	owner.line_of_sight.rotation -= deg_to_rad(90)
	owner.animation_player.play("alert")
	
func exit(msg: = {}) -> void:
	pass
	
func process(delta):
	_time_before_chasing -= delta
	if _time_before_chasing <= 0.0:
		_state_machine.transition_to("Chasing", {Const.PLAYER_LAST_POSITION: _player_last_seen_position})
		return
