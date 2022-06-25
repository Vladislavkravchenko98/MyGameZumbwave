extends "res://Scripts/Men2D.gd"
var target = null

func _ready():
	add_to_group(GlobalVars.barricade_group)
	self.hp = 100
	self.max_hp = 100
	set_start_hp(self.hp, self.max_hp)
	toggle_hp_bar()
	
	var pl = get_parent().get_player()
	target = pl
	
var B = false # Есть бита или баррикада в руках
var A = true #Взята ли в руки баррикада

func _on_BiteArea_area_entered(area): #ПРОВЕРКА ЧТО ОБЛАСТИ СОПРЕКОСНУЛАСЬ С ИГРОКОМ
	B = target.get_BorB()  # Получаем информацию от игрока есть ли у него бита или баррикада в руках на данный момент
	A = target.get_ShotAndBarr()
	
	if area.get_parent() == target and B == false and A == true:    #Проверяем игрок ли подошел и что у него в руках (есть ли бита или баррикада)
		
		get_parent().trigger_on(2)  ###Меняем назначение клавишы стрельбы
		
		$Sprite2.visible = false
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.endless_shooting_L()

func _on_BiteArea_area_exited(area):   #Проверка покинул ли игрок область 
	if area.get_parent() == target:
		
		get_parent().trigger_on(1) ###Возвращаем назначение клавишы стрельбы 
		
		$Sprite2.visible = true 
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.endless_shooting_turnoff()
		


func _process(delta):
	if self.hp <= 0:
		queue_free()
		


func kill():
		reduce_hp(25)            
		if self.hp <= 0:
			queue_free()




func _on_HitBox_area_entered(area):
	
	pass # Replace with function body.


func _on_HitBox_area_exited(area):
	pass # Replace with function body.

