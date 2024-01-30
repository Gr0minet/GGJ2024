extends CharacterBody2D
class_name PNJBase

@onready var skin := $Pivot/AnimatedSprite2D
@onready var reaction_sprite := $Pivot2/Sprite2D
@onready var animation_player := $AnimationPlayer
@onready var raycasts := $RayCasts
@onready var state_machine := $StateMachine

var reaction_laughing_sprite := preload("res://assets/sprites/reaction/laughing.png")
var reaction_chatting1_sprite := preload("res://assets/sprites/reaction/chatting1.png")
var reaction_chatting2_sprite := preload("res://assets/sprites/reaction/chatting2.png")
var reaction_chatting3_sprite := preload("res://assets/sprites/reaction/chatting3.png")
var reaction_alert_sprite := preload("res://assets/sprites/reaction/alert.png")
var reaction_looking_around_sprite := preload("res://assets/sprites/reaction/looking_around.png")
var reaction_sermenting_sprite := preload("res://assets/sprites/reaction/sermenting.png")
	
func raycast_collide(target_position: Vector2) -> bool:
	for raycast: RayCast2D in raycasts.get_children():
		raycast.target_position = target_position
		raycast.force_raycast_update()
		if raycast.is_colliding():
			return true
	return false

func show_reaction(reaction: String) -> void:
	if reaction == Const.REACTION_CHATTING1:
		reaction_sprite.texture = reaction_chatting1_sprite
	elif reaction == Const.REACTION_CHATTING2:
		reaction_sprite.texture = reaction_chatting2_sprite
	elif reaction == Const.REACTION_CHATTING3:
		reaction_sprite.texture = reaction_chatting3_sprite
	elif reaction == Const.REACTION_LAUGHING:
		reaction_sprite.texture = reaction_laughing_sprite
	elif reaction == Const.REACTION_SERMENTING:
		reaction_sprite.texture = reaction_sermenting_sprite
	elif reaction == Const.REACTION_LOOKING_AROUND:
		reaction_sprite.texture = reaction_looking_around_sprite
	elif reaction == Const.REACTION_ALERT:
		reaction_sprite.texture = reaction_alert_sprite
	reaction_sprite.show()
	
func hide_reaction() -> void:
	reaction_sprite.hide()
