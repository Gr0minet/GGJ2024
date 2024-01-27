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
	_wandering_time = randf_range(min_wait, max_wait)

	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var target_position = speed * _direction * _wandering_time
	while owner.raycast_collide(target_position):
		_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		target_position = speed * _direction * _wandering_time
	pnj.velocity = _direction * speed
	_timer.start(_wandering_time)

func exit(msg: = {}) -> void:
	if not _timer.is_stopped():
		_timer.stop()
	
func physics_process(delta: float) -> void:
	pnj.move_and_slide()
	if owner.chasing_raycast_collide():
		_state_machine.transition_to("Chasing")
	
func _wandering_finished() -> void:
	_state_machine.transition_to("Idle")
