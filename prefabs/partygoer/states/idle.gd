extends PartygoerState

var current_direction: Vector2
var current_target: Node2D
var waiting = false
@export var speed = 15.0
@export var distance_to_interest_point = 30.0

func enter(previous_state_path: String, data := {}):
	current_target = pick_target()
	current_direction = get_direction_from_target(current_target)
	partygoer.change_direction_helper(current_direction)
	partygoer.change_cone_colour(Globals.ConeHas.SEEN_NOTHING)
	partygoer.rotation_timer.start()
	

func physics_process(delta):
	if waiting:
		return
	partygoer.mover.move_direction_at_speed(current_direction, speed)
	if in_range_of_target():
		waiting = true
		partygoer.direction_timer.start()
	
func change_direction():
	current_target = pick_target()
	current_direction = get_direction_from_target(current_target)
	partygoer.change_direction_helper(current_direction)
	waiting = false
	
func handle_seeing_something(body):
	if body.is_in_group("Partiers") and body != partygoer:
		partygoer.go_towards_target(body)
		if !body.is_in_group("Player"):
			body.go_towards_target(partygoer)
		else:
			partygoer.exclamation.toggle_show(true)
		
		
func exit():
	partygoer.direction_timer.stop()
	partygoer.rotation_timer.stop()
		
func in_range_of_target():
	return partygoer.global_position.distance_to(current_target.global_position) < distance_to_interest_point 
			
func pick_target():
	assert(!partygoer.points_of_interest.is_empty())
	var picked_target = partygoer.points_of_interest.pick_random()
	while picked_target == current_target:
		picked_target = partygoer.points_of_interest.pick_random()
	return picked_target

func get_direction_from_target(target: Node2D):
	return (target.global_position - partygoer.global_position).normalized()
	
func handle_head_pushing():
	partygoer.push_head(partygoer.head_rotation_amount)
