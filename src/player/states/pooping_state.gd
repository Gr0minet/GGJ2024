extends PlayerState



@export var poop_duration:float = 1.0;

var _poop_timer:float = 0.0

func unhandled_input(event: InputEvent) -> void:
	pass
	
func process(delta: float) -> void:
	if Input.is_action_just_released(Const.INPUT_POOP):
		_state_machine.transition_to("Move")
	elif Input.is_action_pressed(Const.INPUT_POOP):
		_poop_timer += delta;
		print(_poop_timer)
	
	if _poop_timer >= poop_duration:
		player.pooped.emit()
		_state_machine.transition_to("Move")
			
		

func physics_process(delta: float) -> void:
	pass

func enter(msg: = {}) -> void:
	_poop_timer = 0.0
	print("POOPING")
	
func exit(msg: = {}) -> void:
	pass
