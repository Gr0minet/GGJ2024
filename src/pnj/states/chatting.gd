extends PNJState

const CHATTING_TIME := 7.0

var _time_left_chatting := 0.0

func enter(_msg: = {}) -> void:
	owner.skin.play("chatting")
	owner.show_reaction(Const.REACTION_CHATTING3)
	_time_left_chatting = CHATTING_TIME

func exit(_msg: = {}) -> void:
	owner.hide_reaction()
	owner.can_chat = false
	owner.time_before_can_chatting = owner.COOLDOWN_BEFORE_CHATTING

func process(delta):
	_time_left_chatting -= delta
	if _time_left_chatting < 0.0:
		_state_machine.transition_to("Wandering")
