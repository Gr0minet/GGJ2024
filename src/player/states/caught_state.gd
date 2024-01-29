extends PlayerState

func enter(_msg: = {}) -> void:
	owner.skin.play("caught")
