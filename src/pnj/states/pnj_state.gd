extends State
class_name PNJState

var pnj: PNJBase
var skin: Sprite2D

func _ready() -> void:
	super()
	await owner.ready
	pnj = owner
	skin = pnj.skin
