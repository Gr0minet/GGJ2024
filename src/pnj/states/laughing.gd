extends PNJState

var _laugh_timer:float = 0
var _laugh_time_before_points:float = 1.0

func enter(msg: = {}) -> void:
	MusicManager.play_sound_effect(SoundBank.chatting)
	owner.skin.play("laughing")
	_laugh_timer = 0
	owner.show_reaction(Const.REACTION_LAUGHING)
	owner.laughing_area.set_deferred("monitorable", true)
	owner.villageois_detector.set_deferred("monitorable", false)
	owner.villageois_detector.set_deferred("monitoring", false)

func exit(msg: = {}) -> void:
	owner.hide_reaction()
	owner.laughing_area.set_deferred("monitorable", false)
	owner.villageois_detector.set_deferred("monitorable", true)
	owner.villageois_detector.set_deferred("monitoring", true)

func process(delta: float) -> void:
	_laugh_timer += delta
	if _laugh_timer >= _laugh_time_before_points:
		_laugh_timer -= _laugh_time_before_points
		EventBus.score_earned.emit(Const.LAUGHING_SCORE_ADDED)
		
	
