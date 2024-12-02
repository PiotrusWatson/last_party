extends RigidBody2D

var is_ready = false

@export var ammo_type: Globals.AmmoType
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickup_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.has_method("pickup") and is_ready:
		body.pickup()
		queue_free()
	
	if ammo_type == Globals.AmmoType.BEER:
		queue_free()	
	
func _on_time_until_ready_timeout() -> void:
	is_ready = true
