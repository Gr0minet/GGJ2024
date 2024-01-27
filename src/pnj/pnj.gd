extends PNJBase
class_name PNJ

@onready var laughing_area := $LaughingArea
@onready var pnj_detector := $PnjDetector

func _on_pnj_detector_area_entered(area):
	if area != self:
		state_machine.transition_to("Chatting")

func start_laughing() -> void:
	state_machine.transition_to("Laughing")

func stop_laughing() -> void:
	state_machine.transition_to("Idle")
