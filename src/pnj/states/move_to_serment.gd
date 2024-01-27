extends PNJState

@export var speed := 250.0

const SERMENTING_THRESHOD := 160.0

var _target: PNJ
var _target_position := Vector2.ZERO
var _direction := Vector2.ZERO

func enter(msg: = {}) -> void:
	owner.skin.play("wandering")
	owner.modulate = Color.BLACK
	_target = msg["target"]
	_target_position = _target.global_position
	if pnj.position.distance_to(_target_position) > SERMENTING_THRESHOD:
		_direction = (_target_position - pnj.global_position).normalized()
		pnj.velocity = _direction * speed
		owner.line_of_sight.look_at(owner.line_of_sight.global_position + _direction)
		owner.line_of_sight.rotation += rad_to_deg(90)
		if _direction.x > 0:
			skin.flip_h = false
		else:
			skin.flip_h = true
	else:
		_state_machine.transition_to("Sermenting", {target = _target})
		return

func exit(msg: = {}) -> void:
	owner.modulate = Color.BLACK

func physics_process(delta: float) -> void:
	if owner.line_of_sight.player_is_in_sight():
		_state_machine.transition_to("Chasing")
		return 
	
	if pnj.position.distance_to(_target_position) > SERMENTING_THRESHOD:
		pnj.move_and_slide()
	else:
		_state_machine.transition_to("Sermenting", {target = _target})
		return

