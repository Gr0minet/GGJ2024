extends PNJState

@export var min_wait := 1.0
@export var max_wait := 2.0

@onready var _timer := Timer.new()

var _idling_time := 0.0

func _ready():
	super()
	_timer.timeout.connect(_idling_finished)
	add_child(_timer)
	
func enter(msg: = {}) -> void:
	print(owner.name, " idling")
	_idling_time = randf_range(min_wait, max_wait)
	_timer.start(_idling_time)

func exit(msg: = {}) -> void:
	if not _timer.is_stopped():
		_timer.stop()
		
func _idling_finished() -> void:
	_state_machine.transition_to("Wandering")
