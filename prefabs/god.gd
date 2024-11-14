extends Node

var loss_path = "res://worlds/loss_screen.tscn"
var win_path = "res://worlds/win_screen.tscn"
@onready var game_timer = $GameTimer
@onready var game_tick = $GameTick
signal timer_changed(time)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_changed.emit(int(game_timer.time_left))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die():
	get_tree().change_scene_to_file(loss_path)
	
func win():
	get_tree().change_scene_to_file(win_path)


func _on_game_tick_timeout() -> void:
	timer_changed.emit(int(game_timer.time_left))


func _on_game_timer_timeout() -> void:
	win()
