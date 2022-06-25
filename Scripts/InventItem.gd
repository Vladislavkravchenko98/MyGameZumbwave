extends TextureRect

func set_item(item_name, amount):
	if amount > 0:
		texture = load("res://Sprites/It/%s.png" % item_name)
		$Amount.text = str(amount)
	else:
		item_name = "null"    ###Если кол-во данного предмета = 0, то заменяем на пустое изображение 
		texture = load("res://Sprites/It/%s.png" % item_name)
		$Amount.text = " "
		
	

	
