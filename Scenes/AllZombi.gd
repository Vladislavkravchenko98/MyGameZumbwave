extends Node2D
var max_zombi = 2  ##Сколько Зомби добавить в самом начале
var ZmSc = preload("res://Scenes/Zombimore.tscn")    #Обычный
var ZmSc2 = preload("res://Scenes/Zombi_2more.tscn")  #С мозгами (мятный)



func get_zombi():
		return $Zombi
	
var firstcontinue1 = false #Для первого включения таблички (чтобы продолжить игру нажмите BIG READ BUTTON in castle)
var firstcontinue2 = false
func _ready():
	generating_items()
############################################################################ Проверка есть ли  number_of_wave в сохранение 
	var data = Fs.load_data('Player_saves.txt')
	if data.Music == 1:
		max_zombi = 2
		$Tutorial.start(1)
		Addzombi()
		firstcontinue1 = true
	else:
		number_of_wave = data.numberofwave
		ror2 = mu.get_castle()
		if number_of_wave == 0:
			max_zombi = 0
		else:
			if number_of_wave == 4:
				max_zombi = 16 #(12 зомби появится)
				# Сколько нужно убить зомби для задания
				am = 9
				$Task.start(1)
			elif number_of_wave == 8:
				max_zombi = 20 #(15 зомби появится)
				am = 12
				$Task.start(1)
			elif number_of_wave == 12:
				max_zombi = 24 #(18 зомби появится)
				am = 13
				$Task.start(1)
			elif number_of_wave == 16:
				max_zombi = 28 #(21 зомби появится)
				am = 14
				$Task.start(1)
			elif number_of_wave == 20:
				max_zombi = 32 #(24 зомби появится)
				am = 15
				$Task.start(1)
			elif number_of_wave == 24:
				max_zombi = 32 #(24 зомби появится)
				am = 16
				$Task.start(1)
			elif number_of_wave >= 28 and number_of_wave < 40:
				max_zombi = 36 #(27 зомби появится)
				randomize()
				am = int(rand_range(16, 24))
				$Task.start(1)
			elif number_of_wave >= 40:
				max_zombi = 40 #(30 зомби появится)
				am = 25
				$Task.start(1)
			else:
				max_zombi = 16
				am = 3
				$Task.start(1)
			Addzombi()

	###########################################################################
	
	
var dod = false
####################Номер волны (WAVE) ###################################              
#onready var Wave = get_viewport().get_node("Root/UI/Control/Wave")
####################Arrow (УКАЗАТЕЛЬ) ###################################              
onready var Arrow = get_viewport().get_node("Root/UI/Control/Arrow")
onready var Arrow2 = get_viewport().get_node("Root/UI/Control/Arrow2")
onready var ArrowCastle = get_viewport().get_node("Root/UI/Control/ArrowCastle")
####Появление новых Зомби, если все прошлые умерли####
var allzm = 0 #Сколько зомби в живых на данный момент
var pl = 0 #Жив ли игрок
var number_of_wave = 0 #Счетчик - показывает какая волна на данный момент
func _process(delta):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		pl = 1
	for i in get_tree().get_nodes_in_group(GlobalVars.zombi_group):
			allzm = allzm + 1
	#Если все зомби мертвы, то выключаем указатели, активируем надпись новой волны и увеличиваем кол-во новых зомби
	if allzm == 0:
		Arrow.arrow_turnoff()
		Arrow2.arrow_turnoff()
	ror2 = mu.get_castle()
	if pl == 0 or ror2 == 0:
		ArrowCastle.arrow_turnoff()
	if allzm <= (max_zombi/4)*3-am and dod == false:
		$Continue.start(1)
		UI.zadanie_done(true)
		dod = true
	elif allzm == 0 and firstcontinue1 == true and firstcontinue2 == true and dod == false:
		$FirstContinue.start(1)
		dod = true
		
	#Если два или меньше зомби, то включаются указатели (и если игрока нет, то не заходим сюда)
	elif allzm <=2 and pl == 1:
		var inc = 0
		for j in get_tree().get_nodes_in_group(GlobalVars.zombi_group):
			inc = inc + 1
			if (inc == 1):
				if(allzm == 1):
					Arrow2.arrow_turnoff()
				Arrow.set_arrow(j)
			else:
				Arrow2.set_arrow(j)
	##Указатель на замок
	if ror == true and ror2 == 1 and pl == 1:
		for p in get_tree().get_nodes_in_group(GlobalVars.castle_group):
			ArrowCastle.set_arrow(p)
	allzm = 0
	pl = 0


var ror = false #Нужно ли указывать где замок
var ror2 = 1 #Включение и выключение значения из настроек, чтобы понять нужен ли указатель на замок
onready var mu = GlobalMusic

var zombietutorial = 0
var born_zombie = true
func Addzombi():
	randomize()	
	if max_zombi == 2:      ######
		for i in range(max_zombi):
			zombietutorial = zombietutorial + 1
			var zm = ZmSc.instance()
			
			var a = 2800
			var b = 3340
			if zombietutorial == 1:
				a = int(2146)
				b = int(3340)
			else: 
				a = int(5800)
				b = int(3340)
			
			zm.position.x = a
			zm.position.y = b
			
			add_child(zm)
			firstcontinue2 = true
	else:                ###################################################### Обычная игра
		for i in range(max_zombi/4):
			var zm = ZmSc.instance()
			var a = int(rand_range(300, 9014))
			var b = int(rand_range(300, 6230))
			
			zm.position.x = a
			zm.position.y = b
			
			add_child(zm)
		for i in range(max_zombi/4):
			var zm2 = ZmSc2.instance()
			var a2 = int(rand_range(300, 9014))
			var b2 = int(rand_range(300, 6230))
			
			zm2.position.x = a2
			zm2.position.y = b2
			
			add_child(zm2)
		for i in range(max_zombi/4):
			var zm3 = ZmSc2.instance()
			var a3 = int(rand_range(300, 9014))
			var b3 = int(rand_range(300, 6230))
			
			zm3.position.x = a3
			zm3.position.y = b3
			
			add_child(zm3)


onready var UI = get_viewport().get_node("Root/UI")   ##Тут ссылаемся на интерфейс
var timer = 0
func _on_Tutorial_timeout():
	timer = timer + 1
	if timer == 2:
		UI.End_Tutorial()
		UI.tutorial_turnon()
		$Tutorial.stop()
	pass # Replace with function body.

var am = 0 #Число которое отображается на табличке задания (сколько зомби нужно убить)
var timer2 = 0
func _on_Task_timeout():
	timer2 = timer2 + 1
	if timer2 == 1:
		UI.Task_turnon(am)
		$Task.stop()
	pass # Replace with function body.


var timer3 = 0
func _on_Continue_timeout():
	timer3 = timer3 + 1
	if timer3 == 1:
		UI.Continue_turnon()
		ror = true
		$Continue.stop()
	pass # Replace with function body.
	
var timer4 = 0
func _on_FirstContinue_timeout():
	timer4 = timer4 + 1
	if timer4 == 1:
		UI.FirstContinue_turnon()
		ror = true
		$FirstContinue.stop()
	pass # Replace with function body.
	
####Появление лута в домиках
onready var item = preload("res://Scenes/Item2.tscn")
onready var item2 = preload("res://Scenes/Item2.tscn")
onready var item3 = preload("res://Scenes/Item2.tscn")
onready var item4 = preload("res://Scenes/Item2.tscn")
onready var item5 = preload("res://Scenes/Item2.tscn")
onready var item6 = preload("res://Scenes/Item2.tscn")
onready var item7 = preload("res://Scenes/Item2.tscn")
onready var item8 = preload("res://Scenes/Item2.tscn")
onready var item9 = preload("res://Scenes/Item2.tscn")
onready var item11 = preload("res://Scenes/Item2.tscn")
func generating_items():
	var items = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence == 1:
		for i in range(1):
			randomize()
			var a = int(rand_range(0, 3))
			var new_item = item.instance()
			var h = get_parent().get_Items()
			h.add_child(new_item)
			new_item.set_item(items[a]) 

			var a31 = int(6977)
			var b31 = int(485)
			
			new_item.position.x = a31
			new_item.position.y = b31
			
			add_child(new_item)
#2
	var items2 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence2 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence2 == 1:
		for i2 in range(1):
			randomize()
			var a2 = int(rand_range(0, 3))
			var new_item2 = item2.instance()
			var h2 = get_parent().get_Items()
			h2.add_child(new_item2)
			new_item2.set_item(items[a2]) 

			var a32 = int(1831)
			var b32 = int(641)
			
			new_item2.position.x = a32
			new_item2.position.y = b32
			
			add_child(new_item2)
#3
	var items3 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence3 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence3 == 1:
		for i3 in range(1):
			randomize()
			var a3 = int(rand_range(0, 3))
			var new_item3 = item3.instance()
			var h3 = get_parent().get_Items()
			h3.add_child(new_item3)
			new_item3.set_item(items[a3]) 

			var a33 = int(755)
			var b33 = int(3556)
			
			new_item3.position.x = a33
			new_item3.position.y = b33
			
			add_child(new_item3)
#4
	var items4 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence4 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence4 == 1:
		for i4 in range(1):
			randomize()
			var a4 = int(rand_range(0, 3))
			var new_item4 = item4.instance()
			var h4 = get_parent().get_Items()
			h4.add_child(new_item4)
			new_item4.set_item(items[a4]) 

			var a34 = int(7241)
			var b34 = int(3221)
			
			new_item4.position.x = a34
			new_item4.position.y = b34
			
			add_child(new_item4)
#5
	var items5 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence5 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence5 == 1:
		for i5 in range(1):
			randomize()
			var a5 = int(rand_range(0, 3))
			var new_item5 = item5.instance()
			var h5 = get_parent().get_Items()
			h5.add_child(new_item5)
			new_item5.set_item(items[a5]) 

			var a35 = int(8702)
			var b35 = int(2900)
			
			new_item5.position.x = a35
			new_item5.position.y = b35
			
			add_child(new_item5)
#6
	var items6 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence6 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence6 == 1:
		for i6 in range(1):
			randomize()
			var a6 = int(rand_range(0, 3))
			var new_item6 = item6.instance()
			var h6 = get_parent().get_Items()
			h6.add_child(new_item6)
			new_item6.set_item(items[a6]) 

			var a36 = int(1753)
			var b36 = int(4974)
			
			new_item6.position.x = a36
			new_item6.position.y = b36
			
			add_child(new_item6)
#7
	var items7 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence7 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence7 == 1:
		for i7 in range(1):
			randomize()
			var a7 = int(rand_range(0, 3))
			var new_item7 = item7.instance()
			var h7 = get_parent().get_Items()
			h7.add_child(new_item7)
			new_item7.set_item(items[a7]) 

			var a37 = int(3656)
			var b37 = int(4490)
			
			new_item7.position.x = a37
			new_item7.position.y = b37
			
			add_child(new_item7)
#8
	var items8 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence8 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence8 == 1:
		for i8 in range(1):
			randomize()
			var a8 = int(rand_range(0, 3))
			var new_item8 = item8.instance()
			var h8 = get_parent().get_Items()
			h8.add_child(new_item8)
			new_item8.set_item(items[a8]) 

			var a38 = int(4989)
			var b38 = int(5788)
			
			new_item8.position.x = a38
			new_item8.position.y = b38
			
			add_child(new_item8)
#9
	var items9 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence9 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence9 == 1:
		for i9 in range(1):
			randomize()
			var a9 = int(rand_range(0, 3))
			var new_item9 = item9.instance()
			var h9 = get_parent().get_Items()
			h9.add_child(new_item9)
			new_item9.set_item(items[a9]) 

			var a39 = int(7098)
			var b39 = int(5081)
			
			new_item9.position.x = a39
			new_item9.position.y = b39
			
			add_child(new_item9)
#10
	var items11 = ["Apteka", "Gr", "Ammo"]
	var probability_of_occurrence11 = int(rand_range(0, 2))   #Вероятность появления лута
	if probability_of_occurrence11 == 1:
		for i11 in range(1):
			randomize()
			var a11 = int(rand_range(0, 3))
			var new_item11 = item11.instance()
			var h11 = get_parent().get_Items()
			h11.add_child(new_item11)
			new_item11.set_item(items[a11]) 

			var a311 = int(8780)
			var b311 = int(4625)
			
			new_item11.position.x = a311
			new_item11.position.y = b311
			
			add_child(new_item11)
