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

func start_laughing() -> void:
	state_machine.transition_to("Laughing")

func _on_pnj_detector_area_entered(area):
	if area != self:
		state_machine.transition_to("Chatting")
