extends Marker2D
class_name Spawner

@export var parent: Node2D
@export var thing_to_spawn: PackedScene

func spawn_thing(thing: PackedScene):
	var spawned_thing = thing.instantiate()
	parent.add_child(spawned_thing)
	spawned_thing.global_position = global_position
	return spawned_thing

func spawn_saved_thing():
	return spawn_thing(thing_to_spawn)
