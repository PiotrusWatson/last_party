extends Node
class_name PhysicsMover

var body: RigidBody2D
@export var speed: float

func init(body):
	self.body = body

# Called when the node enters the scene tree for the first time.
func push_direction(direction: Vector2):
	push_direction_at_speed(direction, speed)
	
func push_direction_at_speed(direction: Vector2, speed: float):
	body.apply_central_impulse(direction * speed)
