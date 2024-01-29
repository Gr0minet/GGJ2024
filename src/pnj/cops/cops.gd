extends PNJBase
class_name Flic

@onready var laughing_detector := $LaughingDetector
@export var line_of_sight:LineOfSight2D = null

@export var normal_line_of_sight_color:Color = Color("#6eed4749")
@export var chase_line_of_sight_color:Color = Color("#ffb6ac49")
