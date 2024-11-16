extends TextureProgressBar

func init(max_value):
	self.max_value = max_value

func set_anxiety(new_value):
	print(new_value)
	value = max_value - new_value
