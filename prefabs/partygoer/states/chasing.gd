extends PartygoerState

@export var speed = 20
@export var distance_to_target = 20
@export var boredom_threshold = 10
@export var boredom_tick = 1
var boredom: float

var current_direction: Vector2
var at_last_seen = false

func enter(previous_state_path: String, data := {}):
	current_direction = (partygoer.last_seen - partygoer.global_position).normalized()
	boredom = 0
	partygoer.dialogue_displayer.display_text(Dialogues.search_dialogues.pick_random())
	partygoer.boredom_timer.start()

	
func physics_process(delta):
	if !at_last_seen and is_away_from_target():
		partygoer.mover.move_direction_at_speed(current_direction, speed)
	elif !at_last_seen:
		at_last_seen = true
		partygoer.rotation_timer.start()
	
		
func is_away_from_target():
	return partygoer.global_position.distance_to(partygoer.last_seen) > distance_to_target

func handle_head_pushing():
	partygoer.push_head(partygoer.head_rotation_amount)
	
func handle_boredom_tick():
	boredom += boredom_tick
	if boredom >= boredom_threshold:
		partygoer.exclamation.toggle_show(false)
		finished.emit(IDLE)

func exit():
	partygoer.boredom_timer.stop()
	
func handle_seeing_something(body):
	if body.is_in_group("Player"):
		partygoer.go_towards_target(body)
