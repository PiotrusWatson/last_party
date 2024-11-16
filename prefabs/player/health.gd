extends Node
class_name Health


@export var max_health = 100
var health
signal dead

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damage(amount):
	health -= amount
	if health <= 0:
		dead.emit()
	if health > max_health:
		health = max_health
