extends PNJState

@export var min_wait := 3.0
@export var max_wait := 4.0

var _timer := Timer.new()

func _ready() -> void:
	super()
	_timer.timeout.connect(_on_timer_finished)
	add_child(_timer)

func enter(_msg: = {}) -> void:
	owner.skin.play("idle")
	_timer.start(randf_range(min_wait, max_wait))

func exit(_msg: = {}) -> void:
	_timer.stop()

func _on_timer_finished() -> void:
	_state_machine.transition_to("Wandering")
	return
