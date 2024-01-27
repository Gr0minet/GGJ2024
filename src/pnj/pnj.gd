extends CharacterBody2D
class_name PNJ

@onready var skin := $Sprite2D
@onready var raycasts := $RayCasts
@onready var state_machine := $StateMachine
@onready var pnj_detector := $PnjDetector

func raycast_collide(target_position: Vector2) -> bool:
	for raycast: RayCast2D in raycasts.get_children():
		raycast.target_position = target_position
		raycast.force_raycast_update()
		if raycast.is_colliding():
			return true
	return false

func _start_chatting() -> void:
	pnj_detector.set_deferred("monitorable", false)
	pnj_detector.set_deferred("monitoring", false)
	state_machine.transition_to("Chatting")

func _stop_chatting() -> void:
	pnj_detector.set_deferred("monitorable", true)
	pnj_detector.set_deferred("monitoring", true)

func _on_pnj_detector_area_entered(area):
	if area != self:
		_start_chatting()
