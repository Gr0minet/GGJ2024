extends PNJState

@export var speed := 250.0

const SERMENTING_THRESHOD := 160.0

var _target: Villageois
var _target_position := Vector2.ZERO
var _direction := Vector2.ZERO

func enter(msg: = {}) -> void:
	if owner is Flic:
		owner.line_of_sight.set_LOS_color(owner.normal_line_of_sight_color)
	owner.skin.play("wandering")
	_target = msg["target"]
	_target_position = _target.global_position
	if pnj.position.distance_to(_target_position) > SERMENTING_THRESHOD:
		_direction = (_target_position - pnj.global_position).normalized()
		pnj.velocity = _direction * speed
		owner.line_of_sight.look_at(owner.line_of_sight.global_position + _direction)
		owner.line_of_sight.rotation += rad_to_deg(90)
		if _direction.x > 0:
			skin.flip_h = true
		else:
			skin.flip_h = false
	else:
		_state_machine.transition_to("Sermenting", {target = _target})
		return

func physics_process(_delta: float) -> void:
	if owner.line_of_sight.player_is_in_sight():
		var position = owner.line_of_sight.get_player_in_sight().position
		_state_machine.transition_to("Alert", {Const.PLAYER_LAST_POSITION: position})
		return 
	
	if pnj.position.distance_to(_target_position) > SERMENTING_THRESHOD:
		pnj.move_and_slide()
	elif not _target.is_laughing(): 
		_state_machine.transition_to("LookingAround", {target = _target})
		return
	else:
		_state_machine.transition_to("Sermenting", {target = _target})
		return
