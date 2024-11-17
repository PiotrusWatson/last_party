extends Control

var main_scene = "res://worlds/tutorial_scene.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_game():
	get_tree().change_scene_to_file(main_scene)


func _on_play_again_pressed() -> void:
	play_game()


func _on_play_again_win_pressed() -> void:
	play_game()
