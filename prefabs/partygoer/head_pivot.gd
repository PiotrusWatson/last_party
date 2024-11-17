extends Marker2D

@export var pos_limits: Vector2
@onready var head = $Head
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos_limits.x = deg_to_rad(pos_limits.x)
	pos_limits.y = deg_to_rad(pos_limits.y)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rotate_clamped(desired_rotation: float):
	if desired_rotation < pos_limits.x or desired_rotation > pos_limits.y:
		scale.x = -1
	else:
		scale.x = 1
		
	rotation = clampf(desired_rotation, pos_limits.x, pos_limits.y) * scale.x

func push_rotation(amount):
	if rotation + amount > pos_limits.y:
		direction = -1
	if rotation - amount < pos_limits.x:
		direction = 1
	
	rotate_clamped(rotation + (amount * direction))
	
func get_direction():
	return direction
