extends Node2D

@onready var interactable = $Interactable
@onready var bartender_animator = $Bartender/AnimatedSprite2D
var beer_active = false
var giving_beer = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact():
	bartender_animator.play("give_beer")
	giving_beer = true
	interactable.make_interactable(interactable.thing_to_interact_with, false, self)

func _on_interactable_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and !giving_beer and !beer_active:
		interactable.make_interactable(body, true, self)
		

func _on_interactable_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable.make_interactable(body, false, self)


func _on_animated_sprite_2d_animation_finished() -> void:
	if giving_beer:
		beer_active = true
		giving_beer = false
		
	if bartender_animator.animation == "put_hand_away":
		bartender_animator.play("default")


func _on_beer_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and beer_active:
		body.get_beer()
		beer_active = false
		bartender_animator.play("put_hand_away")
