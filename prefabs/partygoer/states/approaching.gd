extends PartygoerState

@export var speed = 30.0
@export var distance_to_stop = 0.5
func enter(previous_state_path: String, data := {}):
	partygoer.dialogue_displayer.display_text(Dialogues.greetings.pick_random())
	
func physics_process(delta):
	partygoer.move_to_target(speed)
	if partygoer.global_position.distance_to(partygoer.target.global_position) < distance_to_stop:
		partygoer.exclamation.toggle_show(false)
		finished.emit(CHATTING)
		

		
	
func handle_no_longer_seeing_something(thing):
	if thing == partygoer.target:
		partygoer.last_seen = thing.global_position
		finished.emit(SEARCHING)
	
