extends PNJState

@export var min_wait := 3.0
@export var max_wait := 4.0

@export var stun_time:float = 1.5

var _idling_time := 0.0
var _idle_timer:float = 0

var stunned:bool = false
	
func enter(msg: = {}) -> void:
	if owner is Flic:
		owner.line_of_sight.set_LOS_color(owner.normal_line_of_sight_color)
	owner.skin.play("idle")
	stunned = false
	owner.velocity = Vector2.ZERO
	_idling_time = randf_range(min_wait, max_wait)
	_idle_timer = 0
	
	if Const.MSG_REASON in msg and msg[Const.MSG_REASON] == "poop":
		MusicManager.play_sound_effect(SoundBank.glissade)
		if owner.skin.flip_h == true:
			owner.animation_player.play("glissing_right")
		else:
			owner.animation_player.play("glissing_left")
		stunned = true
		_idling_time = stun_time
		
func exit(msg: = {}) -> void:
	pass
	
func physics_process(delta):
	_idle_timer += delta
	if owner is Flic and not stunned:
		if owner.line_of_sight.player_is_in_sight():
			var position = owner.line_of_sight.get_player_in_sight().position
			_state_machine.transition_to("Alert", {Const.PLAYER_LAST_POSITION: position})
			return
	
		if owner.laughing_detector.has_overlapping_areas():
			_state_machine.transition_to("MoveToSerment", {target = owner.laughing_detector.get_overlapping_areas()[0].owner})
			return
		
	if _idle_timer > _idling_time:
		if stunned:
			stunned = false
		else:
			if owner is Flic:
				_state_machine.transition_to("LookingAround")
			else:
				_state_machine.transition_to("Wandering")
			return
