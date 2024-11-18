extends Control

var main_scene = "res://worlds/tutorial_scene.tscn"
var menu_scene = "res://worlds/main_menu.tscn"
var credit_scene = "res://worlds/credits_scene.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_game():
	get_tree().change_scene_to_file(main_scene)

func back_to_menu():
	get_tree().change_scene_to_file(menu_scene)
	
func _on_play_again_pressed() -> void:
	play_game()

func _on_play_again_win_pressed() -> void:
	play_game()

func _on_back_pressed() -> void:
	back_to_menu()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file(credit_scene)
