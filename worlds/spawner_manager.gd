extends Node

@export var guests_to_spawn: Array[PackedScene]
@onready var guest_timer = $TimeToNextGuest

var guests_spawned = []
var all_spawners
var main_spawner
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(guests_to_spawn)):
		guests_spawned.append(false)
	
	all_spawners = get_tree().get_nodes_in_group("Spawner")
	main_spawner = all_spawners[0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_random_guest(spawner: Spawner):
	if all_guests_spawned():
		wipe_guest_list()
	
	var guest_index = find_random_unspawned_guest_index()
	spawner.spawn_thing(guests_to_spawn[guest_index])
	guests_spawned[guest_index] = true
	
	
func all_guests_spawned():
	for guest_spawned in guests_spawned:
		if !guest_spawned:
			return false
	return true

func find_random_unspawned_guest_index():
	var guess = 0
	while guests_spawned[guess]:
		guess = randi_range(0, len(guests_spawned) - 1)
	return guess

func wipe_guest_list():
	for i in range(len(guests_spawned)):
		guests_spawned[i] = false
