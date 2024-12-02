extends TextureRect

@onready var amount = $Amount

func set_amount(new_amount):
	amount.text = str(new_amount)
