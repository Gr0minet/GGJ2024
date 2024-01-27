extends Node2D

@export_category("Game parameters")
@export var nb_police:int = 2
@export var nb_citizen:int = 5

@export_category("Game actors")
@export var poop_scene:PackedScene = null
@export var citizen_scene:PackedScene = null
@export var police_scene:PackedScene = null
@export var player:Player = null

@export var spawn_margins:SpawnMargins = null


# Called when the node enters the scene tree for the first time.
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
			var police_instance := police_scene.instantiate()
			police_instance.position = spawn_margins.get_random_position()
			add_child(police_instance)
	
	
	if citizen_scene != null:
		for i in range(nb_citizen):
			var citizen_instance := citizen_scene.instantiate()
			citizen_instance.position = spawn_margins.get_random_position()
			add_child(citizen_instance)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_pooped() -> void:
	if poop_scene == null:
		push_error("No poop scene")
	
	var poop_instance:Node2D = poop_scene.instantiate()
	poop_instance.position = player.get_poop_position()
	add_child(poop_instance)
