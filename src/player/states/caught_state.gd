extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	pass
	
func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func enter(msg: = {}) -> void:
	owner.skin.play("walking")
	
func exit(msg: = {}) -> void:
	pass
