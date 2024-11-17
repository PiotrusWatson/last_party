extends PartygoerState

@export var boredom_threshold = 40.0
@export var boredom_increment = 5.0
var boredom: float

func enter(previous_state_path: String, data := {}):
	partygoer.velocity = Vector2.ZERO
	boredom = 0
	partygoer.boredom_timer.start()

func handle_boredom_tick():
	boredom += boredom_increment
	print(boredom)
	if boredom >= boredom_threshold:
		finished.emit("Idle")
		
func exit():
	partygoer.boredom_timer.stop()
	
func handle_no_longer_seeing_something(thing):
	if thing == partygoer.target and thing.is_in_group("Player"):
		partygoer.last_seen = thing.global_position
		finished.emit(SEARCHING)
