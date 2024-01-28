extends PNJState

func enter(msg: = {}) -> void:
	owner.modulate = Color.BLUE
	owner.laughing_area.set_deferred("monitorable", true)
	owner.pnj_detector.set_deferred("monitorable", false)
	owner.pnj_detector.set_deferred("monitoring", false)

func exit(msg: = {}) -> void:
	owner.modulate = Color.WHITE
	owner.laughing_area.set_deferred("monitorable", false)
	owner.pnj_detector.set_deferred("monitorable", true)
	owner.pnj_detector.set_deferred("monitoring", true)
