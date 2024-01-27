extends PNJState

@export var min_wait := 2.0
@export var max_wait := 10.0

func enter(msg: = {}) -> void:
	owner.modulate = Color.RED
	owner.pnj_detector.set_deferred("monitorable", false)
	owner.pnj_detector.set_deferred("monitoring", false)

func exit(msg: = {}) -> void:
	owner.pnj_detector.set_deferred("monitorable", true)
	owner.pnj_detector.set_deferred("monitoring", true)
