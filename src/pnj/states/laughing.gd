extends PNJState

func enter(msg: = {}) -> void:
	owner.modulate = Color.BLUE
	owner.laughing_area.set_deferred("monitorable", true)

func exit(msg: = {}) -> void:
	owner.laughing_area.set_deferred("monitorable", false)
	
