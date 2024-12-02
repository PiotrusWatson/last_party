extends RigidBody2D

var beer_ready = false

@onready var hand = $Hand
@export var force = 0.5
@export var full_beer_sprite: Texture2D
@export var empty_beer_sprite: Texture2D
@onready var beer = $Hand/Beer
@onready var beer_sprite = $Hand/Beer/Sprite2D
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

func drink_beer():
	beer_sprite.texture = empty_beer_sprite
	beer_ready = false
	
func activate_beer(is_active):
	if is_active:
		beer_sprite.texture = full_beer_sprite
	beer_ready = is_active
	beer.visible = is_active

func set_clothed(is_clothed):
	hand.set_clothed(is_clothed)
