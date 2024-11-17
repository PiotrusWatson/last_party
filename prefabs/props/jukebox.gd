extends Node2D

@export var tracks :Array[AudioStreamMP3]
@onready var audio_player = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
var current_track = 0

func increase_track():
	current_track += 1
	current_track %= tracks.size()
	
func play_track():
	audio_player.stream = tracks[current_track]
	audio_player.play()
