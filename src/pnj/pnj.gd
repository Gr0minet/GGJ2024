extends PNJBase
class_name PNJ

const COOLDOWN_BEFORE_CHATTING := 3.0

@onready var laughing_area := $LaughingArea
@onready var pnj_detector := $PnjDetector
@onready var time_before_can_chatting := COOLDOWN_BEFORE_CHATTING
@onready var can_chat := false

func _process(delta):
	if not can_chat:
		time_before_can_chatting -= delta
		if time_before_can_chatting <= 0.0:
			can_chat = true
			pnj_detector.set_deferred("monitorable", true)
			pnj_detector.set_deferred("monitoring", true)
			
func _on_pnj_detector_area_entered(area):
	if area != self and can_chat and state_machine.state_name != "Laughing":
		pnj_detector.set_deferred("monitorable", false)
		pnj_detector.set_deferred("monitoring", false)
		state_machine.transition_to("Chatting")

func start_laughing() -> void:
	state_machine.transition_to("Laughing")

func stop_laughing() -> void:
	state_machine.transition_to("Wandering")

