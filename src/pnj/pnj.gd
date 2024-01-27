extends PNJBase
class_name PNJ

func _on_pnj_detector_area_entered(area):
	if area != self:
		state_machine.transition_to("Chatting")

func start_laughing() -> void:
	state_machine.transition_to("Laughing")
