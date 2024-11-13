extends PartygoerState


func enter(previous_state_path: String, data := {}):
	#speech bubble with greeting
	pass
	
func physics_process(delta):
	var direction = (partygoer.target.global_position - partygoer.global_position).normalized()
	partygoer.mover.move_direction(direction)
	partygoer.change_direction_helper(direction)
	if partygoer.global_position.distance_to(partygoer.target.global_position) < partygoer.distance_to_stop:
		finished.emit(CHATTING)
	
