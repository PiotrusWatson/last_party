extends Label

signal finished_showing_text
@onready var fade_timer = $FadeTimer

func _ready() -> void:
	visible = false

func display_text(text_to_show):
	text = text_to_show
	visible = true
	fade_timer.start()
	
func _on_fade_timer_timeout() -> void:
	finished_showing_text.emit()
	visible = false
