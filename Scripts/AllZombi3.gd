extends Node2D
var max_zombi = 2  ##Сколько Зомби добавить в самом начале
var ZmSc = preload("res://Scenes/Zombi.tscn")    #Обычный
var ZmSc2 = preload("res://Scenes/Zombi_2.tscn")  #С мозгами (мятный)
var ZmSc3 = preload("res://Scenes/Zombi_3.tscn") #Толстый
var ZmSc4 = preload("res://Scenes/Zombi_4.tscn") #С шипами
var ZmSc5 = preload("res://Scenes/Zombi_5.tscn") #Босс
var ZmSc6 = preload("res://Scenes/Zombi_6.tscn") #Без футболки
var ZmSc7 = preload("res://Scenes/Zombi_7.tscn") #Взрывающийся 
var hz = 0
var howmany = 3

func get_zombi():
		return $Zombi
	

func _ready():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		print('a')
	else:
		number_of_wave = data.numberofwave
	
	
####################Номер волны (WAVE) ###################################              
onready var Wave = get_viewport().get_node("Root/UI/Control/Wave")
onready var Wave2 = get_viewport().get_node("Root/UI/Control/Wave2")
####################Arrow (УКАЗАТЕЛЬ) ###################################              
onready var Arrow = get_viewport().get_node("Root/UI/Control/Arrow")
onready var Arrow2 = get_viewport().get_node("Root/UI/Control/Arrow2")
####Появление новых Зомби, если все прошлые умерли####
var allzm = 0 #Сколько зомби вживых на данный момент
var pl = 0 #Жив ли игрок
var number_of_wave = 0 #Счетчик - показывает какая волна на данный момент
func _process(delta):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group): # Проверка жив ли персонаж
		pl = 1
	for i in get_tree().get_nodes_in_group(GlobalVars.zombi_group):  # Проверка сколько зомби в живых
		allzm = allzm + 1
	if volna2 == true and allzm <= howmany and endalive == true and allzm > 0:                            # Создание волн зомби внутри волн
		volna2 = false
		endalive = false
		Addzombi()
	#Если все зомби мертвы, то выключаем указатели, активируем надпись новой волны и увеличиваем кол-во новых зомби
	if allzm == 0 and zapret == false:
		Arrow.arrow_turnoff()
		Arrow2.arrow_turnoff()
		Wave.set_wave(1)
		number_of_wave = number_of_wave + 1
		vl = 1
		Addzombi()
	#Если два или меньше зомби, то включаются указатели (и если игрока нет, то не заходим сюда)
	elif allzm <=2 and pl == 1 and yoy == true and endalive == true and vl == 3:
		var inc = 0
		for j in get_tree().get_nodes_in_group(GlobalVars.zombi_group):
			inc = inc + 1
			if (inc == 1):
				if(allzm == 1):
					Arrow2.arrow_turnoff()
				Arrow.set_arrow(j)
			else:
				Arrow2.set_arrow(j)
	allzm = 0
	pl = 0
		
var yoy = true  # нужно чтобы стрелки (указатели на 2 последних зомби) не появились
var cx = null   ###координата по x и y где появится зомби
var cy = null
###Получение "рандомных" координат 
func Coordinates(m):
	if m == 0:
		cx = 778
		cy = 226
	elif m == 1:
		cx = 3597
		cy = -128
	elif m == 2:
		cx = 6439
		cy = 181
	elif m == 3:
		cx = 750
		cy = 1682
	elif m == 4:
		cx = 6667
		cy = 1670
	elif m == 5:
		cx = 811
		cy = 3534
	elif m == 6:
		cx = 3634
		cy = 3809
	elif m == 7:
		cx = 6631
		cy = 3561
onready var UI = get_viewport().get_node("Root/UI") 
var numberofwave2 = 0
var zapret = false
var volna2 = false ####Если нужны волны внутри волны

var vl = 1   #счетчик для волн внутри волн (например, во второй волне)
######################## ОСНОВНАЯ ПРОДУМКА ЛОГИКИ ВОЛН ##########################################################
func Addzombi():
	randomize()
	if (int(number_of_wave) % 4) == 0: ######################################################################### Меняем сцену на выполнение задания
		zapret = true
		numberofwave2 = Wave.get_wave()
		$Timer2.start(1)
	elif number_of_wave >= 1:           #####зарандомить
		Zombi_alive0()
		if vl == 1:
			random_for_tot()
			endalive = false
			howmany = int(rand_range(3, 6))
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			random_for_tot2()
			endalive = false
			howmany = int(rand_range(4, 7))
			volna2 = true
			vl = vl + 1
		elif vl == 3:
			random_for_tot3()
			#vl = 1

###### Рандомайзер для раундов и до бесконечности
func random_for_tot():
	randomize()
	var f = 4         #######во сколько раз изменяем с каждой 10 волной вероятность 
	if number_of_wave <= 10:
		f = 3
	elif number_of_wave > 10 and number_of_wave <= 20:
		f = 2
	elif number_of_wave > 20 and number_of_wave <= 30:
		f = 1
	elif number_of_wave > 30:
		f = 0.5
	var k1 = 2*f
	var k2 = 2*f
	var k3 = 2*f
	var k4 = 2*f
	var k5 = 8*f
	var k6 = 5*f
	var k7 = 2*f


	var ab1 = int(rand_range(0, k1)) #k1 k2 k3 ... k7
	var ab2 = int(rand_range(0, k2))
	var ab3 = int(rand_range(0, k3))
	var ab4 = int(rand_range(0, k4))
	var ab5 = int(rand_range(0, k5))
	var ab6 = int(rand_range(0, k6))
	var ab7 = int(rand_range(0, k7))
	if ab1 == 0 or ab1 == 1 or ab1 == 2:
		#Zombi_alive1()
		if number_of_wave < 10:
			tot1 = int(rand_range(0, 10)) #0..0
		else:
			tot1 = int(rand_range(0, 16))
		vid1 = true
	if ab2 == 0 or ab2 == 1:
		#Zombi_alive2()
		if number_of_wave < 40:
			tot2 = int(rand_range(0, 8))
		else:
			tot2 = int(rand_range(0, 12))
		vid2 = true
	if ab3 == 0:
		#Zombi_alive3()
		if number_of_wave < 20:
			tot3 = int(rand_range(0, 3))
		else:
			tot3 = int(rand_range(0, 4))
		vid3 = true
	if ab4 == 0:
		#Zombi_alive4()
		if number_of_wave < 25:
			tot4 = int(rand_range(0, 3))
		else:
			tot4 = int(rand_range(0, 4))
		vid4 = true
	if ab6 == 0 or ab6 == 1:
		#Zombi_alive6()
		if number_of_wave < 15:
			tot6 = int(rand_range(0, 6))
		else:
			tot6 = int(rand_range(0, 8))
		vid6 = true
	if ab7 == 0 or ab7 == 1 or ab7 == 2:
		#Zombi_alive7()
		if number_of_wave < 10:
			tot7 = int(rand_range(0, 10))
		else: 
			tot7 = int(rand_range(6, 18))
		vid7 = true
	$Timer.start(1)
######
func random_for_tot2():
	randomize()
	
	var colzb = 0
	for zb in get_tree().get_nodes_in_group(GlobalVars.zombie2w_group):
		colzb = colzb + 1
	
	if colzb == 0:  #(Если в первой части волны не появились сильные зомби, то добавим их тут. Или добавим)
		if number_of_wave >= 12: #(Добавление сильных зомби зависит от волны (от 12 волны))
			#Zombi_alive3()
			if number_of_wave < 20:
				tot3 = int(rand_range(1, 4))
			else:
				tot3 = int(rand_range(1, 5))
			vid3 = true
			#Zombi_alive4()
			if number_of_wave < 25:
				tot4 = int(rand_range(1, 4))
			else:
				tot4 = int(rand_range(1, 5))
			vid4 = true
		else:
			var tro = int(rand_range(0, 3))
			if tro == 0:
				tot3 = int(rand_range(1, 4))
				vid3 = true
			elif tro == 1:
				tot4 = int(rand_range(1, 4))
				vid4 = true
			elif tro == 2:
				tot1 = int(rand_range(6, 12))
				vid1 = true
				tot7 = int(rand_range(6, 8))
				vid7 = true
		if number_of_wave >= 16:   #(Если волны больше и ровна 16, то может выпасть зомби босс)
			var ab5 = int(rand_range(0, 5))
			if ab5 == 0:
				#Zombi_alive5()
				if number_of_wave < 30:
					tot5 = int(rand_range(0, 1))
				else:
					tot5 = int(rand_range(0, 2))
				vid5 = true
	else:   #(Добавление зомби, если сильные уже есть)
		if number_of_wave < 10:
			tot1 = int(rand_range(2, 10)) 
		else:
			tot1 = int(rand_range(3, 16))
		vid1 = true
		#Zombi_alive7()
		if number_of_wave < 10:
			tot7 = int(rand_range(4, 10))
		else: 
			tot7 = int(rand_range(6, 18))
		vid7 = true
		
		var kpop = int(rand_range(0, 4))  #Доавлю сильных зомби с какой-то вероятностью до 12 волны, даже если они появились в 1/3 (но только если 2 max)
		if colzb == 1 or colzb == 2:
			if kpop == 0:
				tot3 = int(rand_range(0, 1))
				vid3 = true
				kpop = int(rand_range(0, 3))
			if kpop == 1:
				tot4 = int(rand_range(0, 1))
				vid4 = true

	$Timer.start(1)
######
func random_for_tot3():
	randomize()


	var ab1 = int(rand_range(0, 3)) 
	var ab2 = int(rand_range(0, 2))
	var ab5 = int(rand_range(0, 2))
	var ab6 = int(rand_range(0, 2))
	var ab7 = int(rand_range(0, 3))
	if ab1 == 0 :
		#Zombi_alive1()
		if number_of_wave < 15:
			tot1 = int(rand_range(1, 10)) #0..0
		else:
			tot1 = int(rand_range(1, 16))
		vid1 = true
	if ab2 == 0 :
		#Zombi_alive2()
		if number_of_wave < 15:
			tot2 = int(rand_range(1, 8))
		else:
			tot2 = int(rand_range(1, 12))
		vid2 = true
	if ab6 == 0 :
		#Zombi_alive6()
		if number_of_wave < 15:
			tot6 = int(rand_range(1, 6))
		else:
			tot6 = int(rand_range(1, 8))
		vid6 = true
	if ab7 == 0:
		#Zombi_alive7()
		if number_of_wave < 10:
			tot7 = int(rand_range(1, 10))
		else: 
			tot7 = int(rand_range(6, 18))
		vid7 = true
		
	if ab1 != 0 and ab2 != 0 and ab6 != 0 and ab7 != 0:
		if number_of_wave < 15:
			tot2 = int(rand_range(2, 5))
		else:
			tot2 = int(rand_range(2, 8))
		vid2 = true
		if number_of_wave < 15:
			tot6 = int(rand_range(3, 6))
		else:
			tot6 = int(rand_range(2, 8))
		vid6 = true
	$Timer.start(1)
################################################################################################################
###Функции добавления зомби, тоже нулевого (как и в z_alive1), но для обязательного появления
func Zombi_alive0():
	randomize()
	var d = int(rand_range(0, 8))
	cx = 3762
	cy = -139
	var zm = ZmSc.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)

###Функции добавления зомби
func Zombi_alive1():
	randomize()
	var d = int(rand_range(0, 8))
	Coordinates(d)
	var zm = ZmSc.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)
	
func Zombi_alive2():
	randomize()
	var d = int(rand_range(0, 8))
	Coordinates(d)
	var zm = ZmSc2.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)
	
func Zombi_alive3():
	randomize()
	var d = int(rand_range(0, 8))
	Coordinates(d)
	var zm = ZmSc3.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)
	
func Zombi_alive4():
	randomize()
	var d = int(rand_range(0, 8))
	Coordinates(d)
	var zm = ZmSc4.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)
	
func Zombi_alive5():
	randomize()
	var d = int(rand_range(0, 8))
	Coordinates(d)
	var zm = ZmSc5.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)
	
func Zombi_alive6():
	randomize()
	var d = int(rand_range(0, 8))
	Coordinates(d)
	var zm = ZmSc6.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)
	
func Zombi_alive7():
	randomize()
	var d = int(rand_range(0, 8))
	Coordinates(d)
	var zm = ZmSc7.instance()
	zm.position.x = cx
	zm.position.y = cy
	add_child(zm)

var time = 0
var tot1 = -1           #сколько зомби нужно
var tot2 = -1 
var tot3 = -1 
var tot4 = -1 
var tot5 = -1 
var tot6 = -1 
var tot7 = -1 

var vid1 = false           #какой вид зомби нужен 
var vid2 = false
var vid3 = false
var vid4 = false
var vid5 = false
var vid6 = false
var vid7 = false

var zashel = false  #показывает все ли зомби завершели возраждение в функции таймера
var endalive = false
var supertimer = 0
func _on_Timer_timeout():
	supertimer = supertimer + 1
	if supertimer == 1:
		if time == tot1:
			vid1 = false
			tot1 = -1
			time = 0
		elif time == tot2:
			vid2 = false
			tot2 = -1
			time = 0
		elif time == tot3:
			vid3 = false
			tot3 = -1
			time = 0
		elif time == tot4:
			vid4 = false
			tot4 = -1
			time = 0
		elif time == tot5:
			vid5 = false
			tot5 = -1
			time = 0
		elif time == tot6:
			vid6 = false
			tot6 = -1
			time = 0
		elif time == tot7:       
			vid7 = false
			tot7 = -1
			time = 0
		elif vid1 == true: 
			time = time + 1
			Zombi_alive1()
			zashel = true
		elif vid2 == true: 
			time = time + 1
			Zombi_alive2()
			zashel = true
		elif vid3 == true: 
			time = time + 1
			Zombi_alive3()
			zashel = true
		elif vid4 == true: 
			time = time + 1
			Zombi_alive4()
			zashel = true
		elif vid5 == true: 
			time = time + 1
			Zombi_alive5()
			zashel = true
		elif vid6 == true: 
			time = time + 1
			Zombi_alive6()
			zashel = true
		elif vid7 == true: 
			time = time + 1
			Zombi_alive7()
			zashel = true
		else:
			$Timer.stop()
			endalive = true
		#zashel = false
		supertimer = 0


#######################################################################################################

var timer2 = 5
func _on_Timer2_timeout():
	timer2 = timer2 - 1
	Wave2.set_wave(timer2)
	if timer2 == 0:
		UI.set_allinc() #Сохраняем значение дополнительного лута
		UI.set_numberofwave(numberofwave2) #Сохраняем значение текущей волны
		UI.save_level()
		get_tree().change_scene("res://Scenes/Root.tscn")
	pass # Replace with function body.
#########################################################################################################
