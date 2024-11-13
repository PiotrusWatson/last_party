extends Camera2D

@export var thing_to_follow: Node
@export var speed = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = lerp(position, thing_to_follow.position, speed)
