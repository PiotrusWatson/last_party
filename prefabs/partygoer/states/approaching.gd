extends PartygoerState

@export var speed = 30.0
@export var distance_to_stop = 0.5
func enter(previous_state_path: String, data := {}):
	#speech bubble with greeting
	pass
	
func physics_process(delta):
	var direction = (partygoer.target.global_position - partygoer.global_position).normalized()
	partygoer.mover.move_direction_at_speed(direction, speed)
	partygoer.change_direction_helper(direction)
	if partygoer.global_position.distance_to(partygoer.target.global_position) < distance_to_stop:
		finished.emit(CHATTING)
	
