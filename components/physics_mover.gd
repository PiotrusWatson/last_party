extends Node
class_name PhysicsMover

var body: RigidBody2D
@export var speed: float

func init(body):
	self.body = body

# Called when the node enters the scene tree for the first time.
func push_direction(direction: Vector2):
	body.apply_central_impulse(direction * speed)
	
