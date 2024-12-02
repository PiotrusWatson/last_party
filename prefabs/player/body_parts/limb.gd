extends RigidBody2D

@onready var clothed = $Clothed
@onready var unclothed = $Unclothed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_clothed(true)


func set_clothed(is_clothed):
	clothed.visible = is_clothed
	unclothed.visible = !is_clothed
		
