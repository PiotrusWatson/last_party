extends Marker2D

@export var pos_limits: Vector2
@onready var head = $Head

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

	
