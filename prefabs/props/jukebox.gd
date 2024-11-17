extends Node2D

@export var tracks :Array[AudioStreamMP3]
@onready var audio_player = $AudioStreamPlayer2D
@onready var interactable = $Interactable
# Called when the node enters the scene tree for the first time.
var current_track = 0

func _ready():
	play_track()

func interact():
	increase_track()
	play_track()

func increase_track():
	current_track += 1
	current_track %= tracks.size()
	
func play_track():
	audio_player.stream = tracks[current_track]
	audio_player.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable.make_interactable(body, true, self)
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable.make_interactable(body, false, self)
