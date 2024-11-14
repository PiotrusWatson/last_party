extends Polygon2D

const NOT_SEEN = 0
const SEEN_PLAYER = 1
const SEEN_OTHER_PARTYGOER = 2

@export var normal_colour: Color
@export var seen_player_colour: Color
@export var seen_other_partygoer_colour: Color
# Called when the node enters the scene tree for the first time.

func change_colour_by_choice(type_of_condition):
	if type_of_condition == NOT_SEEN:
		color = normal_colour
	elif type_of_condition == SEEN_PLAYER:
		color = seen_player_colour
	else:
		color = seen_other_partygoer_colour
		
