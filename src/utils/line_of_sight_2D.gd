extends Node2D
class_name LineOfSight2D

signal body_entered(body:Node2D)
signal body_exited(body:Node2D)
signal area_entered(area:Area2D)
signal area_exited(area:Area2D)

signal player_entered(player:Player)

@export_category("Raycast parameters")
@export_range(0, 360) var angle_degree:float = 45
@export var ray_count:int = 100
@export var view_distance:int = 500

@export_flags_2d_physics var collision_blocking_layer: int = 0
@export var LOS_collider:CollisionPolygon2D = null

@export var LOS_renderer:Polygon2D = null

@export var LOS_color:Color = Color("#6eed4749")


var _los_points:Array[Vector2] = []

@onready var _angle_rad = deg_to_rad(angle_degree)
@onready var _angle_half = _angle_rad/2.0
@onready var _angle_delta = _angle_rad / ray_count

@onready var LOS_area:Area2D = $LOSArea



# Called when the node enters the scene tree for the first time.
func _ready():
	LOS_renderer.color = LOS_color
	
	LOS_area.body_entered.connect(func(body:Node2D):
		if body is Player:
			var player = body as Player
			player_entered.emit(player)
	)

func set_LOS_color(col:Color) -> void:
	LOS_renderer.color = col

func player_is_in_sight() -> bool:
	return get_player_in_sight() != null

func get_player_in_sight() -> Player:
	for body:Node2D in LOS_area.get_overlapping_bodies():
		if body is Player:
			return body
	return null


func _physics_process(delta):
	_calculate_vision()


func _calculate_vision():
	_los_points.clear()
	_los_points = calculate_vision_shape()
	_update_los_collider()
	_update_los_renderer()

func calculate_vision_shape() -> Array[Vector2]:
	var new_points:Array[Vector2] = []
	
	if _angle_rad < 2*PI:
		new_points.append(Vector2.ZERO)
	
	var direct_space_state:PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	
	var ray_start:Vector2 = global_position
	
	# make the owner not block raycasting
	var exclude:Array = [owner]
	print("%s: %s" % [owner, get_world_2d().direct_space_state])
	# cast rays
	for i in range(ray_count +1):
		# cast ray
		var direction:Vector2 = Vector2(0, view_distance).rotated(_angle_delta * i + global_rotation - _angle_half)
		
		var destination:Vector2 = global_position + direction
		
		var query = PhysicsRayQueryParameters2D.create(
			ray_start, 
			destination, 
			collision_blocking_layer,
			exclude
		)

		var collision = direct_space_state.intersect_ray(query)
		
		var view_point:Vector2 = destination
		
		if collision:
			view_point = collision["position"]
		
		view_point = to_local(view_point)
		new_points.append(view_point)
	
	if _angle_rad < 2*PI:
		new_points.append(Vector2.ZERO)

	return new_points

func _update_los_collider():
	if LOS_collider == null:
		return
	
	LOS_collider.polygon.clear()
	var poly = PackedVector2Array()
	poly.append_array(_los_points)
	LOS_collider.polygon = poly

func _update_los_renderer():
	if LOS_renderer == null:
		return
	
	LOS_renderer.polygon = LOS_collider.polygon #PackedVector2Array(_los_points)

