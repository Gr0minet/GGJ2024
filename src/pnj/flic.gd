extends PNJBase
class_name Flic

@onready var laughing_detector := $LaughingDetector
@export var line_of_sight:LineOfSight2D = null

func on_walk_on_poop() -> void:
	print("WALK ON POOP HAHA")
	state_machine.transition_to("Idle", {Const.MSG_REASON: "poop"})
