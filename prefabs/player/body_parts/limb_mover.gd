extends RigidBody2D

@onready var hand = $Hand
@export var force = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to_target(target: Vector2):
	hand.apply_central_impulse(target * force)
