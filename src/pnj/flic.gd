extends PNJBase
class_name Flic

func chasing_raycast_collide() -> bool:
	pass
	return true
	

func get_raycast_target_position() -> Vector2:
	# return _chasing_raycast.get_collider()
	pass
	return Vector2.ZERO
	
func _on_laughing_detector_area_entered(area):
	state_machine.transition_to("MoveToSerment", {target_position = area.global_position})
