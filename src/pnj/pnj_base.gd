extends CharacterBody2D
class_name PNJBase

@onready var skin := $Sprite2D
@onready var raycasts := $RayCasts
@onready var state_machine := $StateMachine

func raycast_collide(target_position: Vector2) -> bool:
	for raycast: RayCast2D in raycasts.get_children():
		raycast.target_position = target_position
		raycast.force_raycast_update()
		if raycast.is_colliding():
			return true
	return false
