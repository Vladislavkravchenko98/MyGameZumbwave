extends Control

func _ready():
	pass # Replace with function body.


#Право 
func _on_TouchScreenButton2_released():
	if $Sprite.visible == true:
		$Sprite.visible = false
		$Sprite2.visible = true
	elif $Sprite2.visible == true:
		$Sprite2.visible = false
		$Sprite3.visible = true
	elif $Sprite3.visible == true:
		$Sprite3.visible = false
		$Sprite5.visible = true
	elif $Sprite5.visible == true:
		$Sprite5.visible = false
		$Sprite.visible = true
	pass # Replace with function body.
	
#Лево
func _on_TouchScreenButton3_released():
	if $Sprite.visible == true:
		$Sprite.visible = false
		$Sprite5.visible = true
	elif $Sprite5.visible == true:
		$Sprite5.visible = false
		$Sprite3.visible = true
	elif $Sprite3.visible == true:
		$Sprite3.visible = false
		$Sprite2.visible = true
	elif $Sprite2.visible == true:
		$Sprite2.visible = false
		$Sprite.visible = true
	pass # Replace with function body.


