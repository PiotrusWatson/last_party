extends Node

@export var ammo_types: Array[PackedScene]
@export var amount_of_ammo: Array[int]
var ammo_cursor = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_ammo():
	if get_ammo_count() <= 0:
		return null
	if amount_of_ammo[ammo_cursor] <= 0:
		ammo_cursor += 1
		ammo_cursor %= ammo_types.size()
	var ammo_type = ammo_types[ammo_cursor]
	amount_of_ammo[ammo_cursor] -= 1
	return ammo_type
	
func get_ammo_count():
	var count = 0
	for ammo_counter in amount_of_ammo:
		count += ammo_counter
	return count
