extends State
class_name PlayerState

var player: Player
var skin: Sprite2D

func _ready() -> void:
	super()
	await owner.ready
	player = owner
	skin = player.skin
