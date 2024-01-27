extends PNJState

var _target_last_position: Vector2

func physics_process(delta: float) -> void:
	if owner.chasing_raycast_collide():
		_target_last_position = owner.get_raycast_target_position()
