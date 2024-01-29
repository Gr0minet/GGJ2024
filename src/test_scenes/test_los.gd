extends Node2D

@export var player:Player = null
@export var poop_scene:PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if player != null:
		player.pooped.connect(_on_player_pooped)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_pooped() -> void:
	if poop_scene == null:
		push_error("No poop scene")
	
	var poop_instance:Node2D = poop_scene.instantiate()
	poop_instance.position = player.get_poop_position()
	add_child(poop_instance)
