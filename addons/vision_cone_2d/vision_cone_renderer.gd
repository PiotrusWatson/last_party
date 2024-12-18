extends Polygon2D


@export var normal_colour: Color
@export var seen_player_colour: Color
@export var seen_other_partygoer_colour: Color
# Called when the node enters the scene tree for the first time.

func change_colour_by_choice(type_of_condition):
	if type_of_condition == Globals.ConeHas.SEEN_NOTHING:
		color = normal_colour
	elif type_of_condition == Globals.ConeHas.SEEN_PLAYER:
		color = seen_player_colour
	else:
		color = seen_other_partygoer_colour
		
