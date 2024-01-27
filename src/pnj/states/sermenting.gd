extends PNJState

func enter(msg: = {}) -> void:
	owner.modulate = Color.DARK_ORANGE
	var target = msg["target"]
	target.stop_laughing()
	_state_machine.transition_to("LookingAround")

func physics_process(delta) -> void:
	if owner.line_of_sight.player_is_in_sight():
		_state_machine.transition_to("Chasing")
		return
