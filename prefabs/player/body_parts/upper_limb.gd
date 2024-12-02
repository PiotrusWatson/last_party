extends RigidBody2D

@onready var lower_limb = $LowerLimb

func set_clothed(is_clothed):
	lower_limb.set_clothed(is_clothed)
