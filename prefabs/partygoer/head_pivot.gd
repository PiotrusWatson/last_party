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
	print("current desired rotation", desired_rotation)
	var limits = pos_limits
	if desired_rotation > deg_to_rad(pos_limits.x) and desired_rotation < deg_to_rad(pos_limits.y):
		#head.scale.x = -1
		limits = neg_limits

	
	global_rotation = clamp(desired_rotation, limits.x, limits.y)
