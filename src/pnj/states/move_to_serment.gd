extends PNJState

@export var speed := 250.0

const SERMENTING_THRESHOD := 160.0

var _target: PNJ
var _target_position := Vector2.ZERO
var _direction := Vector2.ZERO

func enter(msg: = {}) -> void:
	owner.modulate = Color.BLACK
	_target = msg["target"]
	_target_position = _target.global_position
	if pnj.position.distance_to(_target_position) > SERMENTING_THRESHOD:
		_direction = (_target_position - pnj.global_position).normalized()
		pnj.velocity = _direction * speed
	else:
		_state_machine.transition_to("Sermenting", {target = _target})
		return

func physics_process(delta: float) -> void:
	if pnj.position.distance_to(_target_position) > SERMENTING_THRESHOD:
		pnj.move_and_slide()
	else:
		_state_machine.transition_to("Sermenting", {target = _target})
