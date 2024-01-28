extends Node2D

@export var FLIC_SPAW_TIME := 30.0

@export_category("Game parameters")
@export var nb_police:int = 1
@export var nb_citizen:int = 5

@export_category("Game actors")
@export var poop_scene:PackedScene = null
@export var citizen_scene:PackedScene = null
@export var police_scene:PackedScene = null
@export var player:Player = null

@export var spawn_margins:SpawnMargins = null

@onready var _time_before_new_flic := FLIC_SPAW_TIME

func _ready():
	randomize()
	
	if player == null:
		push_error("no player set in game")
		return
	
	player.pooped.connect(_on_player_pooped)
	
	if spawn_margins == null:
		push_error("no spawn margins")
		return
	
	if police_scene != null:
		for i in range(nb_police):
			_spawn(police_scene.instantiate())
			_time_before_new_flic = FLIC_SPAW_TIME
	
	if citizen_scene != null:
		for i in range(nb_citizen):
			_spawn(citizen_scene.instantiate())

func _process(delta):
	_time_before_new_flic -= delta
	if _time_before_new_flic <= 0:
		_spawn(police_scene.instantiate())
		_time_before_new_flic = FLIC_SPAW_TIME

func _on_player_pooped() -> void:
	if poop_scene == null:
		push_error("No poop scene")
	
	var poop_instance:Node2D = poop_scene.instantiate()
	poop_instance.position = player.get_poop_position()
	add_child(poop_instance)

func _spawn(node: Node) -> void:
	node.position = _get_non_collidable_position(node.get_node("CollisionShape2D"))
	add_child(node)

func _get_non_collidable_position(collision_shape: CollisionShape2D) -> Vector2:
	var non_collidable_position: Vector2
	var shape_cast := ShapeCast2D.new()
	shape_cast.shape = collision_shape.shape.duplicate()
	add_child(shape_cast)
	shape_cast.collision_mask = Const.WORLD_LAYER + Const.PLAYER_LAYER + Const.PNJ_LAYER + Const.FLIC_LAYER + Const.POOP_LAYER
	shape_cast.position = spawn_margins.get_random_position()
	shape_cast.force_shapecast_update()
	while shape_cast.is_colliding():
		shape_cast.position = spawn_margins.get_random_position()
		shape_cast.force_shapecast_update()
	non_collidable_position = shape_cast.position
	shape_cast.queue_free()
	return non_collidable_position
