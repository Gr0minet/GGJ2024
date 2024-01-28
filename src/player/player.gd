extends CharacterBody2D
class_name Player

signal pooped

@export var move_speed:int = 300

@onready var skin:AnimatedSprite2D = $Pivot/AnimatedSprite2D
@onready var poop_position:Marker2D = $PoopPosition
@onready var animation_player := $AnimationPlayer

func get_poop_position() -> Vector2:
	return poop_position.global_position
