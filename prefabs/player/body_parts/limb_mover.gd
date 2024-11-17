extends RigidBody2D

var beer_ready = false
@onready var hand = $Hand
@export var force = 0.5
@onready var beer = $Hand/Beer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activate_beer(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to_target(target: Vector2):
	#apply_central_impulse(target * force)
	hand.apply_central_impulse(target * force)
func stretch_to_target(target: Vector2):
	hand.apply_central_impulse(target * force)

func activate_beer(is_active):
	beer_ready = is_active
	beer.visible = is_active
