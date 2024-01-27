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

@export_category("Debug")
@export var debug_ray:bool = true;
@export var debug_shape:bool = true;

var _los_points:Array[Vector2] = []

@onready var _angle_rad = deg_to_rad(angle_degree)
@onready var _angle_half = _angle_rad/2.0
@onready var _angle_delta = _angle_rad / ray_count

@onready var LOS_area:Area2D = $LOSArea



# Called when the node enters the scene tree for the first time.
func _ready():
	LOS_renderer.color = LOS_color
	
	# Not needed but kept in case
	#LOS_area.body_entered.connect(func(body:Node2D):
		#body_entered.emit(body)
	#)
	#LOS_area.body_exited.connect(func(body:Node2D):
		#body_exited.emit(body)
	#)
	#LOS_area.area_entered.connect(func(area:Area2D):
		#area_entered.emit(area)
	#)
	#
	#LOS_area.area_exited.connect(func(area:Area2D):
		#area_entered.emit(area)
	#)
	
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if debug_ray or debug_shape:
		queue_redraw()

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
	
	# cast rays
	for i in range(ray_count +1):
		# cast ray
		var direction:Vector2 = Vector2(0, view_distance).rotated(_angle_delta * i + global_rotation - _angle_half)
		var start:Vector2 = global_position
		var destination:Vector2 = global_position + direction
		
		var query = PhysicsRayQueryParameters2D.create(
			start, 
			destination, 
			collision_blocking_layer
		)
		var collision = get_world_2d().direct_space_state.intersect_ray(query)
		
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
	
	LOS_renderer.polygon = PackedVector2Array(_los_points)

func _draw():
	if len(_los_points) == 0:
		return
	
	var start:Vector2 = _los_points[0]
	var end:Vector2
	for i in range(1, len(_los_points)):
		end = _los_points[i]
		if debug_shape:
			draw_line(start, end, Color.GREEN)
		if debug_ray:
			draw_line(Vector2.ZERO, end, Color(0,0,1, 0.5))
		start = end
