extends AnimatedSprite2D

@onready var interactable = $Interactable

func interact():
	get_tree().change_scene_to_file("res://worlds/piotrus_scene.tscn")
	
func _on_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable.make_interactable(body, true, self)


func _on_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable.make_interactable(body, false, self)
