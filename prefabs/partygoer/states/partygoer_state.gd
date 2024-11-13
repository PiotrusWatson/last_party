extends State
class_name PartygoerState

const IDLE = "Idle"
const APPROACHING = "Approaching"
const CHATTING = "Chatting"

var partygoer : Partygoer

func _ready() -> void:
	await owner.ready
	partygoer = owner as Partygoer
	assert(partygoer != null, "The PartygoerState state type must be used only in the Partygoer scene. It needs the owner to be a Partygoer node.")

func handle_seeing_something(body) -> void:
	pass

func handle_no_longer_seeing_something(body) -> void:
	pass
