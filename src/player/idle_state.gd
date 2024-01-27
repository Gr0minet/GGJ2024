extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	pass
	
func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func enter(msg: = {}) -> void:
	print("entering idle, and message is : ", msg)
	
func exit(msg: = {}) -> void:
	pass
