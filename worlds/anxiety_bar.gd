extends TextureProgressBar
@export var critical_texture_bar: Texture2D
@export var percent_critical = 30
var normal_texture_bar

func init(max_value):
	self.max_value = max_value
	normal_texture_bar = texture_progress

func set_anxiety(new_value):
	value = max_value - new_value
	if (max_value - value) < (max_value / 10) * (percent_critical / 10):
		texture_progress = critical_texture_bar
	else:
		texture_progress = normal_texture_bar
