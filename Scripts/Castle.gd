extends "res://Scripts/Men2D.gd"
var target = null

func _ready():
	$Anim.play("standing")
	$Sprite2.visible = false
	$Sprite3.visible = false
	$Sprite5.visible = false
	$Sprite6.visible = false
	var pl = get_parent().get_parent().get_player()
	target = pl
	
func _process(delta):
	if door == true and inc == false:
		inc = true
		#$Anim.play("lying")
		$Anim.visible = false
		$Sprite5.visible = true
		
		$Castle/CollisionShape2D.disabled = true

var inc = false

func _on_BiteArea_area_entered(area): #ПРОВЕРКА ЧТО ОБЛАСТИ СОПРЕКОСНУЛАСЬ С ИГРОКОМ
	
	if area.get_parent() == target:
		$Sprite.visible = false
		$Sprite2.visible = true
		$Sprite3.visible = true
		$Sprite6.visible = false
		
		
func _on_BiteArea_area_exited(area):   #Проверка покинул ли игрок область 
	if area.get_parent() == target:
		$Sprite.visible = true 
		$Sprite2.visible = false
		$Sprite3.visible = false
		$Sprite6.visible = true
		


var door = false
	


func _on_Castle_area_entered(area):
	if area.get_parent() == target or "Zombi" in area.name:
		$Sprite6.visible = true
		$Anim.play("door")
		$Timer.start(1)



func _on_Castle_area_exited(area):
	pass


func _on_Timer_timeout():
	door = true


func _on_AreaZm_body_entered(body):
	if "Zombi" in body.name:
		$Sprite6.visible = true
		$Anim.play("door")
		$Timer.start(1)

