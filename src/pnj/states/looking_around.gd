extends PNJState

@export var look_around_angle := 90 # en degrés
@export var look_around_speed := 1.5

var _current_angle # en degrés
var _angle_change_direction := 1
var _target_angle: Array[float]
var _target_angle_id := 0
	
func enter(_msg: = {}) -> void:
	owner.skin.play("looking_around")
	owner.show_reaction(Const.REACTION_LOOKING_AROUND)
	
	_current_angle = rad_to_deg(owner.line_of_sight.rotation)
	_angle_change_direction = 1 if randi_range(0, 1) else -1
	_target_angle = []
	_target_angle.append(_current_angle + _angle_change_direction * 90)
	_target_angle.append(_current_angle - _angle_change_direction * 90)
	_target_angle.append(_current_angle)
	_target_angle_id = 0

func exit(_msg: = {}) -> void:
	owner.hide_reaction()

func physics_process(delta):
	owner.line_of_sight.rotation += _angle_change_direction * delta * look_around_speed
	var face_direction = cos(owner.line_of_sight.rotation - deg_to_rad(90))
	if face_direction > 0:
		skin.flip_h = false
	else:
		skin.flip_h = true
	if _angle_change_direction * rad_to_deg(owner.line_of_sight.rotation) > _angle_change_direction * _target_angle[_target_angle_id]:
		_target_angle_id += 1
		_angle_change_direction *= -1

	if owner.line_of_sight.player_is_in_sight():
		var position = owner.line_of_sight.get_player_in_sight().position
		_state_machine.transition_to("Alert", {Const.PLAYER_LAST_POSITION: position})
		return
	if owner.laughing_detector.has_overlapping_areas():
		_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
		return
	if _target_angle_id == 3:
		_state_machine.transition_to("Wandering")
		return

