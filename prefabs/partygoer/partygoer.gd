extends CharacterBody2D

@onready var mover = $Components/CharacterMover
@onready var vision_cone = $VisionCone2D

func _ready() -> void:
	mover.init(self)
	
