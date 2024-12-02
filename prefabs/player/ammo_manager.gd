extends Node
class_name AmmoManager

@export var ammo_types: Array[PackedScene]
@export var max_amount_of_ammo: Array[int]
@export var bonus_ammo_type: PackedScene
@export var max_bonus_ammo_amount = 1

var amount_of_ammo
var bonus_ammo_amount = 0
var ammo_cursor = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	amount_of_ammo = max_amount_of_ammo.duplicate()
	Globals.ammo_amount = amount_of_ammo
	Globals.bonus_ammo_amount = bonus_ammo_amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_ammo():
	if !has_ammo():
		return null
		
	if bonus_ammo_amount > 0:
		bonus_ammo_amount -= 1
		Globals.bonus_ammo_amount -= 1
		return bonus_ammo_type
	if amount_of_ammo[ammo_cursor] <= 0:
		ammo_cursor += 1
		ammo_cursor %= ammo_types.size()
	var ammo_type = ammo_types[ammo_cursor]
	amount_of_ammo[ammo_cursor] -= 1
	return ammo_type

func refill_ammo(ammo_type: Globals.AmmoType):
	if ammo_type == Globals.AmmoType.BEER and ammo_type < max_bonus_ammo_amount:
		bonus_ammo_amount += 1
		Globals.bonus_ammo_amount += 1
	elif amount_of_ammo[ammo_type] < max_amount_of_ammo[ammo_type]:
		amount_of_ammo[ammo_type] += 1
		
func get_ammo_count():
	var count = 0
	for ammo_counter in amount_of_ammo:
		count += ammo_counter
	return count + bonus_ammo_amount

func has_ammo():
	return get_ammo_count() > 0
