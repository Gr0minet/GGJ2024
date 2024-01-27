extends PNJState

var _target_position := Vector2.ZERO

func enter(msg: = {}) -> void:
	owner.modulate = Color.BLACK
	_target_position = msg["target_position"]
	pass
