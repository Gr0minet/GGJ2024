extends PlayerState

const START_MOVING_THRESHOLD:float = 0.01

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
func process(delta: float) -> void:
	_parent.process(delta)

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if (player.velocity.length() > START_MOVING_THRESHOLD):
		_state_machine.transition_to("Move/Walk")

func enter(msg: = {}) -> void:
	pass
	
func exit(msg: = {}) -> void:
	pass
