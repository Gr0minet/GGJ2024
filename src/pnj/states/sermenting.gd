extends PNJState

func enter(msg: = {}) -> void:
	owner.modulate = Color.DARK_ORANGE
	var target = msg["target"]
	target.stop_laughing()
	_state_machine.transition_to("LookingAround")
