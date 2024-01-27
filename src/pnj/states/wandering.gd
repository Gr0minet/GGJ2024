extends PNJState

@export var min_wait := 1.0
@export var max_wait := 2.0
@export var speed := 250.0

@onready var _timer := Timer.new()

var _wandering_time := 0.0
var _direction := Vector2.ZERO

func _ready():
	super()
	_timer.timeout.connect(_wandering_finished)
	add_child(_timer)
	
func enter(msg: = {}) -> void:
	owner.modulate = Color.WHITE

	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var target_position = speed * _direction * _wandering_time
	while owner.raycast_collide(target_position):
		_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		target_position = speed * _direction * _wandering_time
	pnj.velocity = _direction * speed

	_wandering_time = randf_range(min_wait, max_wait)
	_timer.start(_wandering_time)

func exit(msg: = {}) -> void:
	if not _timer.is_stopped():
		_timer.stop()
	
func physics_process(delta: float) -> void:
	pnj.move_and_slide()
	if owner is Flic:
		if owner.line_of_sight.player_is_in_sight():
			_state_machine.transition_to("Chasing")
	if owner is Flic and owner.laughing_detector.has_overlapping_areas():
		_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
	
func _wandering_finished() -> void:
	_state_machine.transition_to("Idle")
