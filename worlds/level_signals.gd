extends Node2D

@onready var player = $Player
@onready var angst_bar = $UI/UI/AnxietyBar
@onready var clock = $UI/UI/Clock
@onready var ammo = $UI/UI/Ammo
@onready var god = $God
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	angst_bar.init(player.max_health)
	ammo.display_ammo(player.ammo)
	player.threw_thing.connect(ammo.display_ammo)
	player.anxiety_changed.connect(angst_bar.set_anxiety)
	player.dead.connect(god.die)
	god.timer_changed.connect(clock.set_time)
	ammo.setup_ammo()
