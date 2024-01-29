extends Node2D
class_name SpawnMargins

@onready var top_left:Marker2D = $top_left
@onready var bottom_right:Marker2D = $bottom_right

func get_random_position() -> Vector2:
	return Vector2(
		randf_range(top_left.position.x, bottom_right.position.x),
		randf_range(top_left.position.y, bottom_right.position.y)
	)
