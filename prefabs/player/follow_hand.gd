extends Marker2D
## super hacky we'll do this better another time
@onready var arm = $"../LeftArm"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = arm.hand.global_position
