extends RayCast2D

var distance
signal found_wall
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	distance = target_position.x


func change_direction(new_direction):
	target_position = position + (new_direction * distance)
