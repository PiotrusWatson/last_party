extends Label
class_name Interactable

var thing_to_interact_with = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Press " + InputMap.action_get_events("Interact")[0].as_text().split(" ")[0]
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func make_interactable(body, is_interactable, parent):
	if body.has_method("set_interactability"):
		body.set_interactability(is_interactable, parent)
	visible = is_interactable
	
	if is_interactable:
		thing_to_interact_with = body
	else:
		thing_to_interact_with = null
		
