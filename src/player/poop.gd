extends Node2D

@onready var skin:Sprite2D = $Sprite2D
@onready var walk_detection_area:Area2D = $WalkDetection
@onready var pnj_detection_area:Area2D = $PNJDetection

# Called when the node enters the scene tree for the first time.
func _ready():
	walk_detection_area.area_entered.connect(_on_walk_on_poop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# When walk on poop, detect pnj in detection area
func _on_walk_on_poop(area:Area2D):
	print("area %s is in group poop : %s" % [area, area.owner.is_in_group(Const.GROUP_WALK_ON_POOP)])
	if !area.owner.is_in_group(Const.GROUP_WALK_ON_POOP):
		return
	
	var pnj_nearby:Array[Node2D] = pnj_detection_area.get_overlapping_bodies()
	print("PNJ nearby: %s" % [len(pnj_nearby)])
	for pnj_area in pnj_nearby:
		var pnj = pnj_area.owner
		print(pnj)
		pnj.start_laughing()
	
	queue_free()
