extends "res://Scripts/Men2D.gd"
var stands = true
var destination = Vector2()
var velocity = Vector2()

var prev_pos = Vector2()

var target = null   #Цель

var d_speed = 50      ####Скорость коотрая включается если Зомби обноружил игрока 

var true_die = false ######################## Перменная отвечающая за то жив или мертв Зомби


##Переменные кот определют что зомби может атаковать
var bite_strength = 50  # Сколько HP БУДЕТ ОТНИМАТЬ ЗОМБИ У ИГРОКА ПРИ ОДНОМ УКУСЕ
var target_intercepted = false  #определение что кто-то находится в области досягаемости
var can_bite = true  #Может ли Зоби атаковать (т.е. чтобы удары были переодическими, а не подряд)
var inc = false#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##!#!#!#!################################################################################# Анимация появления
func _ready():
	speed = 80
	self.hp = 150
	self.max_hp = 150
	set_start_hp(self.hp, self.max_hp)
	add_to_group(GlobalVars.zombi_group)
	add_to_group(GlobalVars.zombie2w_group)
	toggle_hp_bar()

### Передвижение и поиск игрока
func _process(delta):
	if shot1 == true and shot2 == true:
		Shot()
	if velocity and true_die == false:
		if inc == false:###################################################################################################################
			cancel_movement()#################
			$Anim.play("Z")#############
			$Timer3.start(2)#########
		else:#############################################################################
			prev_pos = position
			move_and_slide(velocity)
			position.x = clamp(position.x, 350, 6995)
			position.y = clamp(position.y, -408, 4097)
	
	wander() ####################################################################################wander шло после таргет
	if inc == true:#########################################################################
		searc_for_target()
	
	if target_intercepted and can_bite and true_die == false:  ## активация удара, т.е. обращение к этим функциям
		bite(target)
	
	if target_int == true and can_bite == true and hoh == true and true_die == false:   #!!!! Дамаг по БАРРИКАДЕ
		bite_barr(target_br)
		
	if barr_chain_intercepted == true  and true_die == false and barr_3 == true:
		kill_barr()
		barr_3 = false
		$Timer_Barr_Chain.start(2)        ###### Через какое время по зомби снова проходит дамаг от баррикады_3
		
##### Отнимаем HP у БАРРИКАДЫ
var target_int = false
var target_br = null
var hoh = false
func tot(Barr):
	target_br = Barr
	hoh = true 
	
#Запуск таймера (перезарядки укуса) для БАРРИКАДЫ
func bite_barr(targ_br):
	targ_br.reduce_hp(20)            #####Функция отвечающая за байт
	can_bite = false
	#Запуск таймера
	$Timer.start(1)   ##Время через которое снова зомби атакует
		
func _on_Timer3_timeout():##################################################################################################################
	inc = true
	$Coll_Alive.disabled = true
	$Coll.disabled = false
	$Coll2.disabled = false
	$Coll3.disabled = false
	pass 


func searc_for_target():          #поиск цели
	var pl = get_parent().get_parent().get_player()   # pl - теперь эта переменная позиция игрока
	if pl: ## Если есть кого доставать (чтобы игра не ломалась после смерти ГГ)
		if target and true_die == false:
			if global_position.distance_to(target.global_position) > 10000:      
				cancel_movement()
			else:
				set_destination(target.position)               #################СЮДА ПЕРЕДАЕТСЯ ПОЗИЦИЯ КУДА ИДТИ ....target.position
		elif global_position.distance_to(pl.global_position) < 10000:      #Проверка, что игрок именно близко, тк target может быть не всегда
			cancel_movement()
			speed = d_speed * 2 if speed == d_speed else speed
			target = pl
		
var direction = 1   #Чтобы понять в какую сторону включать анимацию смерти
func set_destination(dest):            ####Создание пути для Зомби
	if true_die == false and inc == true: ##################################################
		destination = dest
		velocity = (destination - position).normalized() * speed
		if velocity.x > 0 and abs(dest.x - position.x) > abs(dest.y - position.y) and true_die == false:   #abs(dest.x - position.x) > abs(dest.y - position.y) and true_die == false:
			$Anim.play("R")
			$HP_bar.rect_position.x = -123
			direction = 1
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false
			"""
$CollR.disabled = false
			$CollL.disabled = true
			$CollL2.disabled = true"""

			######################Колизия для атаки
			$CollR.disabled = false
			$BiteArea/DU1.disabled = true
			$BiteArea/DU2.disabled = true
			$BiteArea/DU3.disabled = true
			$BiteArea/L1.disabled = true
			$BiteArea/L2.disabled = true
			$BiteArea/L3.disabled = true
			$BiteArea/R1.disabled = false
			$BiteArea/R2.disabled = false
			$BiteArea/R3.disabled = false
		elif velocity.x < 0 and true_die == false and abs(dest.x - position.x) > abs(dest.y - position.y):  
			$Anim.play("L")
			$HP_bar.rect_position.x = -81
			direction = 2
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false
			"""
$Coll.disabled = true
			$Coll2.disabled = true
			$Coll3.disabled = true
			$CollL.disabled = true
			$CollL2.disabled = true
			$CollR.disabled = false
			$CollR2.disabled = false"""

			######################Колизия для атаки
			$CollR.disabled = false
			$BiteArea/DU1.disabled = true
			$BiteArea/DU2.disabled = true
			$BiteArea/DU3.disabled = true
			$BiteArea/L1.disabled = false
			$BiteArea/L2.disabled = false
			$BiteArea/L3.disabled = false
			$BiteArea/R1.disabled = true
			$BiteArea/R2.disabled = true
			$BiteArea/R3.disabled = true
		elif velocity.y < 0 and true_die == false:
			$Anim.play("U")
			$HP_bar.rect_position.x = -103
			direction = 2
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false
			"""
$CollR.disabled = true
			$CollR2.disabled = true
			$CollL.disabled = true
			$CollL2.disabled = true
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false"""

			######################Колизия для атаки
			$CollR.disabled = true
			$BiteArea/DU1.disabled = false
			$BiteArea/DU2.disabled = false
			$BiteArea/DU3.disabled = false
			$BiteArea/L1.disabled = true
			$BiteArea/L2.disabled = true
			$BiteArea/L3.disabled = true
			$BiteArea/R1.disabled = true
			$BiteArea/R2.disabled = true
			$BiteArea/R3.disabled = true
		elif true_die == false:
			$Anim.play("D")
			$HP_bar.rect_position.x = -103
			direction = 1
			"""
$CollR.disabled = true
			$CollR2.disabled = true
			$CollL.disabled = true
			$CollL2.disabled = true
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false"""
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false

			######################Колизия для атаки
			$CollR.disabled = true
			$BiteArea/DU1.disabled = false
			$BiteArea/DU2.disabled = false
			$BiteArea/DU3.disabled = false
			$BiteArea/L1.disabled = true
			$BiteArea/L2.disabled = true
			$BiteArea/L3.disabled = true
			$BiteArea/R1.disabled = true
			$BiteArea/R2.disabled = true
			$BiteArea/R3.disabled = true
		#$Anim.flip_h = velocity.x < 0  #Это разворот 
		stands = false
	elif true_die == false and inc == false:################################################ 
		destination = dest
		velocity = (destination - position).normalized() * speed
		if velocity.x < 0 and abs(dest.x - position.x) > abs(dest.y - position.y) and true_die == false:
			$Anim.play("Zidle")
		elif velocity.y < 0 and true_die == false:
			$Anim.play("Zidle")
		elif true_die == false:
			$Anim.play("Zidle")
		#$Anim.flip_h = velocity.x < 0
		stands = false
	

func cancel_movement():   ### Функция для отмены движения
	if true_die == false:
		if inc == false: #################################################################
			$Anim.play("Zidle")##########################################################
			#$CollR.disabled = true
			#$CollL.disabled = true
			#$CollL2.disabled = true
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false
		elif inc == true:###########################################################################
			#$Anim.play("idle")
			#$CollR.disabled = true
			#$CollR2.disabled = true
			#$CollL.disabled = true
			#$CollL2.disabled = true
			$Coll.disabled = false
			$Coll2.disabled = false
			$Coll3.disabled = false
			######################Колизия для атаки
			#$BiteArea/DU1.disabled = false
			#$BiteArea/DU2.disabled = false
			#$BiteArea/DU3.disabled = false
			#$BiteArea/L1.disabled = true
			#$BiteArea/L2.disabled = true
			#$BiteArea/L3.disabled = true
			#$BiteArea/R1.disabled = true
			#$BiteArea/R2.disabled = true
			#$BiteArea/R3.disabled = true
		velocity = Vector2()
		destination = Vector2()
		speed = d_speed
		$StandingTimer.start(2)
		target = null
		
func wander():           #Бродить
	var pos = position
	if stands and true_die == false:
		randomize()
		
		var x = int(rand_range(pos.x - 400, pos.x + 400))
		var y = int(rand_range(pos.y - 400, pos.y + 400))
		
		x = clamp(x, 350, 6995)
		y = clamp(y, -408, 4097)
		
		set_destination(Vector2(x, y))
	
	elif velocity != Vector2() and not target and true_die == false:
		if pos.distance_to(destination) <= speed:
			cancel_movement()
		elif pos.distance_to(prev_pos) <= 0.6:
			cancel_movement()

#Запуск таймера (перезарядки укуса)
func bite(targ):
	targ.reduce_hp(bite_strength)            #####Функция отвечающая за байт
	targ.Damagereal()
	can_bite = false
	#Запуск таймера
	$Timer.start(1)   ##Время через которое снова зомби атакует
	
func _on_StandingTimer_timeout():
	stands = true
	pass 



func _on_Timer_timeout():
	can_bite = true 
	pass # Replace with function body.

var barr_3 = true
var barr_chain_intercepted = false
func _on_BiteArea_area_entered(area): #ПРОВЕРКА ЧТО ОБЛАСТИ СОПРЕКОСНУЛИСЬ ДЛЯ ПРОХОЖДЕНИЯ ДОМАГА  (!!!!ПО ИГРОКУ И БАРРИКАДЕ!!!!)
	if area.get_parent() == target and true_die == false:
		target_intercepted = true 
	
	for i in get_tree().get_nodes_in_group(GlobalVars.barricade_group):
		if  area.get_parent() == i and true_die == false: ##########!@!@!@!@!@!@!@!@
			target_int= true
			tot(i)
	
	for j in get_tree().get_nodes_in_group(GlobalVars.barricade_chain_group):
		if  area.get_parent() == j and true_die == false: 
			barr_chain_intercepted = true
	pass # Replace with function body.


func _on_BiteArea_area_exited(area):   #Проверка покинул ли игрок область атаки
	if area.get_parent() == target and true_die == false:
		target_intercepted = false
	for i in get_tree().get_nodes_in_group(GlobalVars.barricade_group):
		if  area.get_parent() == i and true_die == false: ##########!@!@!@!@!@!@!@!@
			target_int= false
	
	for j in get_tree().get_nodes_in_group(GlobalVars.barricade_chain_group):
		if  area.get_parent() == j and true_die == false: 
			barr_chain_intercepted = false
	pass # Replace with function body.
	
	
###################### Дамаг и Смерть (ОТ ПУЛЬ)##################################

func kill():
	if true_die == false:
		reduce_hp(25)                  # СКОЛЬКО HP ОТНИМАЕМ У ЗОМБИ
		if self.hp <= 0:
			true_die = true
			velocity.x = 0
			velocity.y = 0
			speed = 0
			#toggle_hp_bar()         ######Отключаю отображение HP
			$CollR.disabled = true
			#$CollR2.disabled = true
			$CollL.disabled = true
			$CollL2.disabled = true
			$Coll.disabled = true
			$Coll2.disabled = true
			$Coll3.disabled = true

			$DIE.disabled = false 
			if direction == 2:
				$Anim.play("dieL")
			else:
				$Anim.play("dieR")
			$Timerdie.start(0.6)    ####Запускаю таймер, чтобы анимация успела проиграться   
			
###################### Дамаг и Смерть (ОТ ГРАНАТ)##################################
func kill_gr():
	if true_die == false:
		reduce_hp(100)                  # СКОЛЬКО HP ОТНИМАЕМ У ЗОМБИ
		if self.hp <= 0:
			true_die = true
			velocity.x = 0
			velocity.y = 0
			speed = 0
			#toggle_hp_bar()         
			$CollR.disabled = true
			$CollL.disabled = true
			$CollL2.disabled = true
			$Coll.disabled = true
			$Coll2.disabled = true
			$Coll3.disabled = true
			$DIE.disabled = false
			if direction == 2:
				$Anim.play("dieL")
			else:
				$Anim.play("dieR")
			$Timerdie.start(0.6)    ####Запускаю таймер, чтобы анимация успела проиграться 

#################### Дамаг и смерть от баррикады с цепью ###########################
func kill_barr():
	if true_die == false:
		reduce_hp(20)                  # СКОЛЬКО HP ОТНИМАЕМ У ЗОМБИ
		if self.hp <= 0:
			true_die = true
			velocity.x = 0
			velocity.y = 0
			speed = 0
			#toggle_hp_bar()         
			$CollR.disabled = true
			$CollL.disabled = true
			$CollL2.disabled = true
			$Coll.disabled = true
			$Coll2.disabled = true
			$Coll3.disabled = true
			$DIE.disabled = false 
			if direction == 2:
				$Anim.play("dieL")
			else:
				$Anim.play("dieR")
			$Timerdie.start(0.6)    ####Запускаю таймер, чтобы анимация успела проиграться 

#################### Монетки за убитых зомби ###################################              
onready var Coins = get_viewport().get_node("Root/UI/Control/Coins")

##Ниже написан скрипт исчезнавения Зомби (смерти) и выпадение рандомного лута из него
onready var item = preload("res://Scenes/Item_Barr.tscn")
func _on_Timerdie_timeout():               ###Таймер после которого текстура Зомби исчезает
	ran_it()
	Coins.set_amount(15)  ### Пятнадцать моенток за убийство зомби
	queue_free()
	pass # Replace with function body.
	
	##Выпадение предметов
func ran_it():
	var items = ["Brick", "Chain"]
	var probability_of_occurrence = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence == 1 or probability_of_occurrence == 0:
		for i in range(1):
			randomize()
			var a = int(rand_range(0, 2))
			var new_item = item.instance()
			var h = get_parent().get_parent().get_Items()
			h.add_child(new_item)
			new_item.set_item(items[a]) #####a
			new_item.global_position = global_position

##################################################### ВЫСТРЕЛ ШИПАМИ
const PLASMA = preload("res://Scenes/SpikesR.tscn")
const PLASMA2 = preload("res://Scenes/SpikesL.tscn")
const PLASMA3 = preload("res://Scenes/SpikesD.tscn")
const PLASMA4 = preload("res://Scenes/SpikesU.tscn")

var shot1 = false
var shot2 = false
func Shot():
		var plasma = PLASMA.instance()
		plasma.global_position = $R.position + position
		get_parent().add_child(plasma)
		var plasma2 = PLASMA2.instance()
		plasma2.global_position = $L.position + position
		get_parent().add_child(plasma2)
		var plasma3 = PLASMA3.instance()
		plasma3.global_position = $D.position + position
		get_parent().add_child(plasma3)
		var plasma4 = PLASMA4.instance()
		plasma4.global_position = $U.position + position
		get_parent().add_child(plasma4)
		shot1 = false
		$AllowShoot.start(2)



func _on_Area2D_area_entered(area):
	if area.get_parent() == target:
		shot1 = true 
		shot2 = true
		
func _on_Area2D_area_exited(area):
	if area.get_parent() == target:
			shot2 = false
	
func _on_AllowShoot_timeout():
	shot1 = true

###############################################################################




func _on_Timer_Barr_Chain_timeout():
	barr_3 = true
	pass # Replace with function body.


##############Смерть от супер атаки
func kill_super():
	if true_die == false:
		reduce_hp(400) # СКОЛЬКО HP ОТНИМАЕМ У ЗОМБИ
		if self.hp <= 0:
			true_die = true
			velocity.x = 0
			velocity.y = 0
			speed = 0
			#toggle_hp_bar()         
			$CollR.disabled = true
			$CollL.disabled = true
			$CollL2.disabled = true
			$Coll.disabled = true
			$Coll2.disabled = true
			$Coll3.disabled = true  
			$DIE.disabled = false 
			if direction == 2:
				$Anim.play("dieL")
			else:
				$Anim.play("dieR")
			$Timerdie.start(0.6)   
			

