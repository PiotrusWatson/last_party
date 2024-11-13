extends PartygoerState

var current_direction: Vector2

func enter(previous_state_path: String, data := {}):
	current_direction = partygoer.get_global_transform().x
	partygoer.direction_timer.start()
	

func physics_process(delta):
	partygoer.mover.move_direction(current_direction)

func change_direction():
	current_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	partygoer.change_direction_helper(current_direction)
	
func handle_seeing_something(body):
	if body.is_in_group("Partiers") and body != partygoer:
		partygoer.set_target(body)
		finished.emit(APPROACHING)
		


		
