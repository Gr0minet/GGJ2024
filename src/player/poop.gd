extends Node2D

@export var poop_duration:float = 10.0

var _duration_timer:float = 0

@onready var skin:Sprite2D = $Sprite2D
@onready var walk_detection_area:Area2D = $WalkDetection
@onready var villageois_detection_area:Area2D = $VillageoisDetection

# Called when the node enters the scene tree for the first time.
func _ready():
	walk_detection_area.body_entered.connect(_on_walk_on_poop)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_duration_timer += delta
	if _duration_timer > poop_duration:
		queue_free()

# When walk on poop, detect villageois in detection area
func _on_walk_on_poop(body_who_walked_on_poop:Node2D):
	if !body_who_walked_on_poop.is_in_group(Const.GROUP_WALK_ON_POOP):
		return
		
	body_who_walked_on_poop.on_walk_on_poop()
	
	var villageois_nearby:Array[Node2D] = villageois_detection_area.get_overlapping_bodies()
	for villageois_body in villageois_nearby:
		if body_who_walked_on_poop == villageois_body:
			continue
		villageois_body.start_laughing()
	
	queue_free()
