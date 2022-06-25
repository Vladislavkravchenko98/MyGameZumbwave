extends "res://Scripts/Men2D.gd"
var stands = true
var destination = Vector2()
var velocity = Vector2()

var prev_pos = Vector2()

var target = null   #Цель

var d_speed = 90      ####Скорость коотрая включается если Зомби обноружил игрока 

var true_die = false ######################## Перменная отвечающая за то жив или мертв Зомби


##Переменные кот определют что зомби может атаковать
var bite_strength = 20  # Сколько HP БУДЕТ ОТНИМАТЬ ЗОМБИ У ИГРОКА ПРИ ОДНОМ УКУСЕ
var target_intercepted = false  #определение что кто-то находится в области досягаемости
var can_bite = true  #Может ли Зоби атаковать (т.е. чтобы удары были переодическими, а не подряд)
var inc = false#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##!#!#!#!################################################################################# Анимация появления
func _ready():
	speed = 80
	self.hp = 100
	self.max_hp = 100
	set_start_hp(self.hp, self.max_hp)
	add_to_group(GlobalVars.zombi_group)
	toggle_hp_bar()

### Передвижение и поиск игрока
func _process(delta):
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
		

func set_destination(dest):            ####Создание пути для Зомби
	if true_die == false and inc == true: ##################################################
		destination = dest
		velocity = (destination - position).normalized() * speed
		if abs(dest.x - position.x) > abs(dest.y - position.y) and true_die == false:
			$Anim.play("R")
		elif velocity.y < 0 and true_die == false:
			$Anim.play("U")
		elif true_die == false:
			$Anim.play("D")
		$Anim.flip_h = velocity.x < 0
		stands = false
	elif true_die == false and inc == false:################################################ 
		destination = dest
		velocity = (destination - position).normalized() * speed
		if abs(dest.x - position.x) > abs(dest.y - position.y) and true_die == false:
			$Anim.play("Zidle")
		elif velocity.y < 0 and true_die == false:
			$Anim.play("Zidle")
		elif true_die == false:
			$Anim.play("Zidle")
		$Anim.flip_h = velocity.x < 0
		stands = false
	

func cancel_movement():   ### Функция для отмены движения
	if true_die == false:
		if inc == false: #################################################################
			$Anim.play("Zidle")##########################################################
		elif inc == true:###########################################################################
			$Anim.play("idle")
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
			$Coll.disabled = true   ######Если дохнет, то старая колизия меняется на горизонтальную, тк тело лежит
			$DIE.disabled = false 
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
			$Coll.disabled = true   ######Если дохнет, то старая колизия меняется на горизонтальную, тк тело лежит
			$DIE.disabled = false 
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
			$Coll.disabled = true   ######Если дохнет, то старая колизия меняется на горизонтальную, тк тело лежит
			$DIE.disabled = false 
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
			$Coll.disabled = true   
			$DIE.disabled = false 
			$Anim.play("dieR")
			$Timerdie.start(0.6)   
