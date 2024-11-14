extends PartygoerState

var current_direction: Vector2
@export var speed = 15.0

func enter(previous_state_path: String, data := {}):
	current_direction = partygoer.get_global_transform().x
	partygoer.direction_timer.start()
	partygoer.change_cone_colour(Globals.ConeHas.SEEN_NOTHING)
	

func physics_process(delta):
	partygoer.mover.move_direction_at_speed(current_direction, speed)

func change_direction():
	current_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	partygoer.change_direction_helper(current_direction)
	
func handle_seeing_something(body):
	if body.is_in_group("Partiers") and body != partygoer:
		partygoer.set_target(body)
		set_colour_off_type_of_partier(body)
		finished.emit(APPROACHING)
		
		
func exit():
	partygoer.direction_timer.stop()

func set_colour_off_type_of_partier(body):
	if body.is_in_group("Player"):
		partygoer.change_cone_colour(Globals.ConeHas.SEEN_PLAYER)
	else:
		partygoer.change_cone_colour(Globals.ConeHas.SEEN_PARTYGOER)
