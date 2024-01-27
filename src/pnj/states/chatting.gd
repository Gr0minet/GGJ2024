extends PNJState

@export var min_wait := 2.0
@export var max_wait := 10.0

func enter(msg: = {}) -> void:
	print(owner.name, " chatting")
