extends Marker2D

@export var pos_limits: Vector2
@onready var head = $Head
var neg_limits: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos_limits.x = deg_to_rad(pos_limits.x)
	pos_limits.y = deg_to_rad(pos_limits.y)
	neg_limits.x = -1 * pos_limits.x
	neg_limits.y = -1 * pos_limits.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rotate_clamped(desired_rotation: float):
	desired_rotation = 0
	rotation = 0

	
