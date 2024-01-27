extends PNJState

@export var min_wait := 1.0
@export var max_wait := 2.0

@onready var _timer := Timer.new()

var _looking_around_time := 0.0

func _ready():
	super()
	_timer.timeout.connect(_looking_around_finished)
	add_child(_timer)
	
func enter(msg: = {}) -> void:
	owner.modulate = Color.YELLOW
	
	_looking_around_time = randf_range(min_wait, max_wait)
	_timer.start(_looking_around_time)
	
func exit(msg: = {}) -> void:
	if not _timer.is_stopped():
		_timer.stop()
	
func physics_process(delta):
    if owner.line_of_sight.player_is_in_sight():
		_state_machine.transition_to("Chasing")
	if owner.laughing_detector.has_overlapping_areas():
		_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
    

func _looking_around_finished() -> void:
	_state_machine.transition_to("Wandering")
