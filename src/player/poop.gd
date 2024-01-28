extends Node2D

@export var poop_duration:float = 10.0

var _duration_timer:float = 0

@onready var skin:Sprite2D = $Sprite2D
@onready var walk_detection_area:Area2D = $WalkDetection
@onready var pnj_detection_area:Area2D = $PNJDetection

# Called when the node enters the scene tree for the first time.
func _ready():
	walk_detection_area.body_entered.connect(_on_walk_on_poop)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_duration_timer += delta
	if _duration_timer > poop_duration:
		queue_free()

# When walk on poop, detect pnj in detection area
func _on_walk_on_poop(body:Node2D):
	if !body.is_in_group(Const.GROUP_WALK_ON_POOP):
		return
		
	body.on_walk_on_poop()
	
	var pnj_nearby:Array[Node2D] = pnj_detection_area.get_overlapping_bodies()
	for pnj_body in pnj_nearby:
		if body == pnj_body:
			continue
		pnj_body.start_laughing()
	
	queue_free()
