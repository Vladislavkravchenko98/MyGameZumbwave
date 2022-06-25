extends "res://Scripts/Men2D.gd"
var target = null

func _ready():
	var pl = get_parent().get_parent().get_player()
	target = pl



func _on_BiteArea_area_entered(area): #ПРОВЕРКА ЧТО ОБЛАСТИ СОПРЕКОСНУЛАСЬ С ИГРОКОМ
	
	if area.get_parent() == target:
		$Sprite.visible = false
		$Sprite3.visible = false
		
		
func _on_BiteArea_area_exited(area):   #Проверка покинул ли игрок область 
	if area.get_parent() == target:
		$Sprite.visible = true 
		$Sprite3.visible = true




func _on_HitBox_area_entered(area):
	pass
	 
	


func _on_HitBox_area_exited(area):
	pass # Replace with function body.
