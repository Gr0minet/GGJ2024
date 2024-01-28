extends PNJState

const WANDERING_CHANGE_PROBA := 0.7
const CONSECUTIVE_WANDERING_MAX_ANGLE := 60 # en degrés
const MAX_LOOP_NUMBER := 100

@export var min_wait := 0.5
@export var max_wait := 1.0
@export var speed := 250.0

@onready var _timer := Timer.new()

var _consecutive_angle := 0.0
var _wandering_time := 0.0
var _direction := Vector2.ZERO

func _ready():
	super()
	_timer.timeout.connect(_wandering_finished)
	add_child(_timer)
	
func enter(msg: = {}) -> void:
	owner.skin.play("wandering")

	var previous_direction := Vector2(0, 0)
	if Const.PREVIOUS_DIRECTION in msg:
		previous_direction = msg[Const.PREVIOUS_DIRECTION]
	var target_position = _generate_target_position(previous_direction)
	var loop_number := 0
	while owner.raycast_collide(target_position) or (Const.PREVIOUS_DIRECTION in msg and abs(_consecutive_angle) > CONSECUTIVE_WANDERING_MAX_ANGLE):
		if loop_number > MAX_LOOP_NUMBER:
			if owner is Flic:
				_state_machine.transition_to("LookingAround")
			else:
				_state_machine.transition_to("Idle")
			return
		target_position = _generate_target_position(previous_direction)
		loop_number += 1

	pnj.velocity = _direction * speed
	if pnj.velocity.x > 0:
		skin.flip_h = true
	else:
		skin.flip_h = false

	_timer.start(_wandering_time)
	if owner is Flic:
		owner.line_of_sight.look_at(owner.line_of_sight.global_position + _direction)
		owner.line_of_sight.rotation += rad_to_deg(90)

func exit(msg: = {}) -> void:
	if not _timer.is_stopped():
		_timer.stop()
	
func physics_process(delta: float) -> void:
	pnj.move_and_slide()
	if owner is Flic:
		if owner.line_of_sight.player_is_in_sight():
			var position = owner.line_of_sight.get_player_in_sight().position
			_state_machine.transition_to("Alert", {Const.PLAYER_LAST_POSITION: position})
			return
		if owner.laughing_detector.has_overlapping_areas():
			_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
			return

func _wandering_finished() -> void:
	var proba := randf_range(0.0, 1.0)
	if proba <= WANDERING_CHANGE_PROBA:
		_state_machine.transition_to("Wandering", {Const.PREVIOUS_DIRECTION: _direction})
	else:
		if owner is Flic:
			_state_machine.transition_to("LookingAround")
		else:
			_state_machine.transition_to("Idle")

func _generate_target_position(previous_direction: Vector2 = Vector2(0, 0)) -> Vector2:
	_wandering_time = randf_range(min_wait, max_wait)
	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	if previous_direction != Vector2(0, 0):
		_consecutive_angle = rad_to_deg(previous_direction.angle_to(_direction))
	return speed * _direction * _wandering_time
