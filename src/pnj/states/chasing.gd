extends PNJState

const DISTANCE_LOST_THRESHOLD:float = 10

@export var chase_speed:int = 250

var _target_last_position: Vector2

func enter(msg: = {}) -> void:
	var player:Player = owner.line_of_sight.get_player_in_sight()
	if player == null:
		_state_machine.transition_to("LookingAround")
		return
	_target_last_position = player.position

func exit(msg: = {}) -> void:
	pass

func physics_process(delta: float) -> void:
	var player:Player = owner.line_of_sight.get_player_in_sight()
	owner.line_of_sight.look_at(_target_last_position)
	owner.line_of_sight.rotation -= deg_to_rad(90)
	if player == null:
		if owner.position.distance_to(_target_last_position) < DISTANCE_LOST_THRESHOLD:
			_state_machine.transition_to("LookingAround")
			return
	
	if player != null:
		_target_last_position = player.position
	
	var direction:Vector2 = (_target_last_position - owner.position).normalized()
	owner.velocity = direction * chase_speed
	
	if owner.velocity.x > 0:
		owner.skin.flip_h = true
	elif owner.velocity.x < 0:
		owner.skin.flip_h = false
	
	owner.move_and_slide()
	var dist = owner.position.distance_to(_target_last_position)
	print("Dist to target: %s" % dist)
	if owner.position.distance_to(_target_last_position) < DISTANCE_LOST_THRESHOLD:
			_state_machine.transition_to("LookingAround")
			return
	
	
	
