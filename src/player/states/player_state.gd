extends State
class_name PlayerState

var player: Player
var skin: AnimatedSprite2D

func _ready() -> void:
	super()
	await owner.ready
	player = owner
	skin = player.skin
