extends PartygoerState

@export var fade_speed = 3
# Called when the node enters the scene tree for the first time.
func enter(previous_state_path: String, data := {}):
	partygoer.set_transparency(0)
	partygoer.say_intro()

func process(delta):
	partygoer.fade_in(fade_speed*delta)

func exit():
	partygoer.set_transparency(255)
	
func handle_spawn_timer_over():
	finished.emit(IDLE)
