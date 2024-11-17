extends Node2D

@export var tracks :Array[AudioStreamMP3]
# Called when the node enters the scene tree for the first time.
var current_track = 0

func increase_track():
	current_track += 1
	current_track %= tracks.size()
	
