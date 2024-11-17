extends Node

@export var thing_to_throw: PackedScene
@export var throw_location: Node2D
@export var throw_force = 30.0
@export var recoil = 40.0

signal threw_something(direction, speed)
var thrown_stuff
func init(thrown_stuff):
	self.thrown_stuff = thrown_stuff
	
func throw_object(direction: Vector2):
	var thrown_thing = thing_to_throw.instantiate() as RigidBody2D
	thrown_stuff.add_child(thrown_thing)
	thrown_thing.global_position = throw_location.global_position
	thrown_thing.apply_central_impulse(direction * throw_force)
	threw_something.emit(-1 * direction, recoil)
	
