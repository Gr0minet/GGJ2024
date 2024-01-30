extends PNJState

@export var stun_time:float = 1.5

var _idle_timer:float = 0
	
func enter(_msg: = {}) -> void:
	owner.line_of_sight.set_LOS_color(owner.normal_line_of_sight_color)
	owner.skin.play("glissing")

	MusicManager.play_sound_effect(SoundBank.glissade)
	if owner.skin.flip_h == true:
		owner.animation_player.play("glissing_right")
	else:
		owner.animation_player.play("glissing_left")
	_idle_timer = stun_time
	
func physics_process(delta):
	_idle_timer -= delta
	if _idle_timer <= 0 :
		_state_machine.transition_to("LookingAround")
