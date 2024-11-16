extends Label
class_name Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Press " + InputMap.action_get_events("Interact")[0].as_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func make_interactable(body, interactability):
	if body.has_method("set_interactability"):
		body.set_interactability(interactability)
		
