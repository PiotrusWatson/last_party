extends Node
class_name CharacterMover

var body: CharacterBody2D
@export var speed = 10.0

# Called when the node enters the scene tree for the first time.
func init(body: CharacterBody2D) -> void:
	self.body = body


func move_direction(direction: Vector2) -> void:
	move_direction_at_speed(direction, speed)
	
func move_direction_at_speed(direction: Vector2, new_speed: float) -> void:
	body.velocity = direction * new_speed
	body.move_and_slide()
