extends Node2D

@onready var _next_flic_id:int = 0

@export_category("Game parameters")
@export var FLIC_SPAWN_TIMER:Array[float] = [0.0, 20.0, 60.0, 100.0]
@export var nb_citizen:int = 8
@export var target_score:int = 300

@export_category("Game scenes")
@export var poop_scene:PackedScene = null

@export var villageois_scenes:Array[PackedScene] = [
	preload("res://src/pnj/villageois/villageois.tscn"),
	preload("res://src/pnj/villageois/villageois2.tscn")
]

@export var police_scene:PackedScene = null
@export var player:Player = null
@export var HUD:HUDCanvas = null
@export var end_menu:EndMenuCanvas = null

@export var spawn_margins:SpawnMargins = null

@export var game_music:AudioStream = null

### Game rules variables ###
var _current_score:int = 0

@onready var _timer := 0.0

func _ready():
	randomize()
	end_menu.hide()
	MusicManager.play_music(game_music)

	_current_score = 0
	
	if player == null:
		push_error("no player set in game")
		return
	
	player.pooped.connect(_on_player_pooped)
	
	EventBus.score_earned.connect(_on_score_gained)
	EventBus.doggo_caught.connect(_lose)
	
	if HUD == null:
		push_error("no HUD")
		return

	
	_init_HUD()
	_init_level()

func _process(delta):
	if _next_flic_id < len(FLIC_SPAWN_TIMER):
		_timer += delta
		if _timer >= FLIC_SPAWN_TIMER[_next_flic_id]:
			_spawn(police_scene.instantiate())
			_next_flic_id += 1

func _on_player_pooped() -> void:
	if poop_scene == null:
		push_error("No poop scene")
	
	var poop_instance:Node2D = poop_scene.instantiate()
	poop_instance.position = player.get_poop_position()
	add_child(poop_instance)

func _init_HUD() -> void:
	HUD.set_current_score(_current_score)
	HUD.set_max_score(target_score)

######################
# GAME RULES
######################

func _on_score_gained(amount:int) -> void:
	_current_score += amount
	HUD.set_current_score(_current_score)
	
	if _current_score >= target_score:
		_win()


func _game_over() -> void:
	get_tree().paused = true
	end_menu.show()
	end_menu.play_end_music()
	

func _win() -> void:
	end_menu.set_win()
	_game_over()

func _lose() -> void:
	end_menu.set_lose()
	_game_over()
	

########################
# LEVEL GENERATION
#######################

func _init_level() -> void:
	if spawn_margins == null:
		push_error("no spawn margins")
		return
	
	if villageois_scenes != []:
		for i in range(nb_citizen):
			var random_villageois_scene := randi_range(0, len(villageois_scenes) - 1)
			_spawn(villageois_scenes[random_villageois_scene].instantiate())

func _spawn(node: Node) -> void:
	node.position = _get_non_collidable_position(node.get_node("CollisionShape2D"))
	add_child(node)

func _get_non_collidable_position(collision_shape: CollisionShape2D) -> Vector2:
	var non_collidable_position: Vector2
	var shape_cast := ShapeCast2D.new()
	shape_cast.shape = collision_shape.shape.duplicate()
	add_child(shape_cast)
	shape_cast.collision_mask = Const.WORLD_LAYER + Const.PLAYER_LAYER + Const.VILLAGEOIS_LAYER + Const.FLIC_LAYER + Const.POOP_LAYER
	shape_cast.position = spawn_margins.get_random_position()
	shape_cast.force_shapecast_update()
	while shape_cast.is_colliding():
		shape_cast.position = spawn_margins.get_random_position()
		shape_cast.force_shapecast_update()
	non_collidable_position = shape_cast.position
	shape_cast.queue_free()
	return non_collidable_position
