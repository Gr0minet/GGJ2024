extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	pass
	
func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	player.velocity = direction * player.move_speed
	
	player.move_and_slide()
	
	print("Player velocity:", player.velocity)

func enter(msg: = {}) -> void:
	pass
	
func exit(msg: = {}) -> void:
	pass
