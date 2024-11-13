extends Node
class_name CharacterMover

var body: CharacterBody2D
@export var speed = 10.0

# Called when the node enters the scene tree for the first time.
func init(body: CharacterBody2D) -> void:
	self.body = body


func move_direction(direction: Vector2) -> void:
	body.velocity = direction * speed
	body.move_and_slide()
