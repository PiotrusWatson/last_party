extends Node2D

@onready var player = $Player
@onready var angst_bar = $UI/UI/AnxietyBar
@onready var god = $God
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.anxiety_changed.connect(angst_bar.set_anxiety)
	player.dead.connect(god.die)
