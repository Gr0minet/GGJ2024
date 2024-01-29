extends PNJBase
class_name Villageois

const COOLDOWN_BEFORE_CHATTING := 3.0

@onready var laughing_area := $LaughingArea
@onready var villageois_detector := $VillageoisDetector
@onready var time_before_can_chatting := COOLDOWN_BEFORE_CHATTING
@onready var can_chat := false

func _process(delta):
	if not can_chat:
		time_before_can_chatting -= delta
		if time_before_can_chatting <= 0.0:
			can_chat = true
			villageois_detector.set_deferred("monitorable", true)
			villageois_detector.set_deferred("monitoring", true)
			
func _on_villageois_detector_area_entered(area):
	if area != self and can_chat and state_machine.state_name != "Laughing":
		villageois_detector.set_deferred("monitorable", false)
		villageois_detector.set_deferred("monitoring", false)
		state_machine.transition_to("Chatting")

func start_laughing() -> void:
	state_machine.transition_to("Laughing")

func stop_laughing() -> void:
	state_machine.transition_to("Wandering")

func is_laughing() -> bool:
	return state_machine.state_name == "Laughing"
