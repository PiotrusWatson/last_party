class_name Conversation

var participant1: Partygoer
var participant2: Partygoer
var left_leader = false
func _init(participant1, participant2):
	self.participant1 = participant1
	self.participant2 = participant2
	var coin_flip = randi_range(0, 1)
	left_leader = bool(coin_flip)

func decide_rant():
	if left_leader:
		self.participant1.say_rant()
	else:
		self.participant2.say_rant()
func decide_response():
	if left_leader:
		participant2.say_response()
	else:
		self.participant1.say_response()
