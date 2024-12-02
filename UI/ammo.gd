extends HBoxContainer

#TODO: not hardcode this :(
@onready var boot = $Boot
@onready var glove = $Glove
@onready var bottle = $Bottle

func setup_ammo():
	boot.set_amount(Globals.ammo_amount[0])
	glove.set_amount(Globals.ammo_amount[1])
	bottle.set_amount(Globals.bonus_ammo_amount)
	
func display_ammo(ammo_type):
	if ammo_type == Globals.AmmoType.BOOT:
		boot.set_amount(Globals.ammo_amount[0])
	elif ammo_type == Globals.AmmoType.GLOVE:
		glove.set_amount(Globals.ammo_amount[1])
	else:
		bottle.set_amount(Globals.bonus_ammo_amount)
