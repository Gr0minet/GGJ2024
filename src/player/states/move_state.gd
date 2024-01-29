extends PlayerState

func process(_delta: float) -> void:
	if (Input.is_action_just_pressed(Const.INPUT_POOP)):
		_state_machine.transition_to("Pooping")

func physics_process(_delta: float) -> void:
	var direction:Vector2 = Input.get_vector(Const.INPUT_LEFT, Const.INPUT_RIGHT, Const.INPUT_UP, Const.INPUT_DOWN)
	player.velocity = direction * player.move_speed
	
	if Input.get_axis(Const.INPUT_LEFT, Const.INPUT_RIGHT) < 0:
		player.skin.flip_h = true
	elif Input.get_axis(Const.INPUT_LEFT, Const.INPUT_RIGHT) > 0:
		player.skin.flip_h = false
	
	player.move_and_slide()
	
func enter(_msg: = {}) -> void:
	_state_machine.transition_to("Move/Idle")
	
