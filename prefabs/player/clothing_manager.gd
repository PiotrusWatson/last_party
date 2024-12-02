extends Node2D

@onready var left_arm = $LeftArm
@onready var left_leg = $LeftLeg
@onready var right_arm = $RightArm
@onready var right_leg = $RightLeg

#incredibly gross. TODO: fix to something nicer at some point in future
func handle_clothing():
	var ammo_counts = Globals.ammo_amount
	if ammo_counts[Globals.AmmoType.BOOT] == 1:
		left_leg.set_clothed(false)
		right_leg.set_clothed(true)
	elif ammo_counts[Globals.AmmoType.BOOT] == 0:
		left_leg.set_clothed(false)
		right_leg.set_clothed(false)
	else:
		left_leg.set_clothed(true)
		right_leg.set_clothed(true)
	
	if ammo_counts[Globals.AmmoType.GLOVE] == 1:
		left_arm.set_clothed(false)
		right_arm.set_clothed(true)
	elif ammo_counts[Globals.AmmoType.GLOVE] == 0:
		left_arm.set_clothed(false)
		right_arm.set_clothed(false)
	else:
		left_arm.set_clothed(true)
		right_arm.set_clothed(true)
