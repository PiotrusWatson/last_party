extends Node2D

@onready var interactable = $Interactable
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact():
	if interactable.thing_to_interact_with.has_method("get_beer"):
		interactable.thing_to_interact_with.get_beer()
		interactable.make_interactable(interactable.thing_to_interact_with, false, self)


func _on_interactable_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable.make_interactable(body, true, self)
		

func _on_interactable_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable.make_interactable(body, false, self)
