extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	pass
	
func process(delta: float) -> void:
	if (Input.is_action_just_pressed(Const.INPUT_POOP)):
		_state_machine.transition_to("Pooping")

func physics_process(delta: float) -> void:
	
	var direction:Vector2 = Input.get_vector(Const.INPUT_LEFT, Const.INPUT_RIGHT, Const.INPUT_UP, Const.INPUT_DOWN)
	player.velocity = direction * player.move_speed
	
	player.move_and_slide()
	

func enter(msg: = {}) -> void:
	print("MOVING")
	_state_machine.transition_to("Move/Idle")
	
func exit(msg: = {}) -> void:
	pass
