extends PartygoerState

@export var boredom_threshold = 5.0
@export var boredom_increment = 1.0
var boredom: float
var conversation: Conversation
var my_turn = false
func enter(previous_state_path: String, data := {}):
	partygoer.velocity = Vector2.ZERO
	boredom = 0
	partygoer.boredom_timer.start()
	if partygoer.target.is_in_group("Player"):
		return
	conversation = Conversation.new(partygoer, partygoer.target)
	partygoer.conversation_leader = true
	partygoer.target.conversation_leader = false
	my_turn = conversation.left_leader

func handle_boredom_tick():
	boredom += boredom_increment
	if conversation != null:
		if my_turn:
			conversation.decide_rant()
			my_turn = false
		else:
			conversation.decide_response()
			my_turn = true
	if boredom >= boredom_threshold:
		finished.emit("Idle")
	
		
func exit():
	partygoer.boredom_timer.stop()
	
func handle_no_longer_seeing_something(thing):
	if thing == partygoer.target and thing.is_in_group("Player"):
		partygoer.last_seen = thing.global_position
		partygoer.exclamation.toggle_show(true)
		finished.emit(SEARCHING)
		
