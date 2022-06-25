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
	Addzombi()
	
	
####################Номер волны (WAVE) ###################################              
onready var Wave = get_viewport().get_node("Root/UI/Control/Wave")
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
	if allzm == 0:
		#Arrow.arrow_turnoff()
		#Arrow2.arrow_turnoff()
		Wave.set_wave(1)
		number_of_wave = number_of_wave + 1
		max_zombi = max_zombi + 1    ### Сколько зомби добавляется
		Addzombi()
	#Если два или меньше зомби, то включаются указатели (и если игрока нет, то не заходим сюда)
	elif allzm <=2 and pl == 1 and yoy == true:
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
		
var yoy = false  # нужно чтобы стрелки (указатели на 2 последних зомби) не появились
var cx = null   ###координата по x и y где появится зомби
var cy = null
###Получение "рандомных" координат 
func Coordinates(m):
	if m == 0:
		cx = 634
		cy = 364
	elif m == 1:
		cx = 3900
		cy = 364
	elif m == 2:
		cx = 7072
		cy = 299
	elif m == 3:
		cx = 634
		cy = 2031
	elif m == 4:
		cx = 7072
		cy = 2031
	elif m == 5:
		cx = 634
		cy = 3784
	elif m == 6:
		cx = 3900
		cy = 3784
	elif m == 7:
		cx = 7072
		cy = 3784

var volna2 = false ####Если нужны волны внутри волны
var volna3 = false
var vl = 1   #счетчик для волн внутри волн (например, во второй волне)
######################## ОСНОВНАЯ ПРОДУМКА ЛОГИКИ ВОЛН ##########################################################
func Addzombi():
	randomize()
	if number_of_wave == 1: #################################################### 1
		for i in range(2):
			var zm = ZmSc.instance()
			var a = int(rand_range(2000, 2200))
			var b = int(rand_range(2000, 2000))
			
			zm.position.x = a
			zm.position.y = b
			
			add_child(zm)
	
	elif number_of_wave == 2:################################################### 2 (5 3) 8
		if vl == 1:
			Zombi_alive1()
			tot1 = 4
			vid1 = true
			$Timer.start(0)
			howmany = 3
			volna2 = true
			vl = vl + 1
		elif vl == 2:                         
			Zombi_alive2()
			tot2 = 2
			vid2 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave == 3:################################################### 3 (4 4 4)      12
		if vl == 1:
			endalive = false
			Zombi_alive2()
			tot2 = 3
			vid2 = true
			$Timer.start(0)
			howmany = 2
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			endalive = false
			Zombi_alive1()
			tot1 = 3
			vid1 = true
			$Timer.start(0)
			howmany = 2
			volna2 = true
			vl = vl + 1
		elif vl == 3:
			Zombi_alive6()
			tot6 = 3
			vid6 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave == 4:################################################### 4 (4 7 4)     15
		if vl == 1:
			endalive = false
			Zombi_alive1()
			tot1 = 3
			vid1 = true
			tot2 = 2
			vid2 = true
			$Timer.start(0)
			howmany = 4
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			endalive = false
			Zombi_alive1()
			tot1 = 6
			vid1 = true
			$Timer.start(0)
			howmany = 2
			volna2 = true
			vl = vl + 1
		elif vl == 3:
			Zombi_alive6()
			tot6 = 3
			vid6 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave == 5:################################################### 5  (11) 
		if vl == 1:
			endalive = false
			Zombi_alive2()
			tot2 = 6
			vid2 = true
			tot4 = 2
			vid4 = true
			$Timer.start(0)
			howmany = 4
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			Zombi_alive6()
			tot6 = 3
			vid6 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave == 6:################################################### 6 (14)
			endalive = false
			Zombi_alive1()
			tot1 = 11
			vid1 = true
			tot7 = 2
			vid7 = true
			$Timer.start(0)
	elif number_of_wave == 7:################################################### 7  14
			endalive = false
			Zombi_alive1()
			tot1 = 11
			vid1 = true
			tot7 = 2
			vid7 = true
			tot4 = 2
			vid4 = true
			$Timer.start(0)
	elif number_of_wave == 8:################################################### 8 
		if vl == 1:
			endalive = false
			Zombi_alive7()
			tot7 = 14
			vid7 = true
			$Timer.start(0)
			howmany = 4
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			endalive = false
			Zombi_alive1()
			tot1 = 6
			vid1 = true
			$Timer.start(0)
			howmany = 2
			volna2 = true
			vl = vl + 1
		elif vl == 3:
			Zombi_alive2()
			tot2 = 5
			vid2 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave == 5:################################################### 9  (11)
		if vl == 1:
			endalive = false
			Zombi_alive7()
			tot4 = 2
			vid4 = true
			tot7 = 10
			vid7 = true
			$Timer.start(0)
			howmany = 4
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			Zombi_alive3()
			tot3 = 2
			vid3 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave == 10:################################################### 10  (11)
		if vl == 1:
			endalive = false
			Zombi_alive3()
			tot4 = 3
			vid4 = true
			tot3 = 3
			vid3 = true
			$Timer.start(0)
			howmany = 4
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			Zombi_alive1()
			tot1 = 10
			vid1 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave == 11:################################################### 11  (11)
		if vl == 1:
			endalive = false
			Zombi_alive1()
			tot1 = 15
			vid1 = true
			tot3 = 4
			vid3 = true
			$Timer.start(0)
			howmany = 4
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			Zombi_alive2()
			tot2 = 4
			vid2 = true
			$Timer.start(0)
			vl = 1
	elif number_of_wave >= 12:           #####зарандомить
		if vl == 1:
			random_for_tot()
			endalive = false
			howmany = int(rand_range(1, 4))
			volna2 = true
			vl = vl + 1
		elif vl == 2:
			random_for_tot()
			endalive = false
			howmany = int(rand_range(1, 6))
			volna2 = true
			vl = vl + 1
		elif vl == 3:
			random_for_tot()
			vl = 1

###### Рандомайзер для раунда 11 и до бесконечности
func random_for_tot():
	randomize()
	var ab1 = int(rand_range(0, 8))
	var ab2 = int(rand_range(0, 4))
	var ab3 = int(rand_range(0, 4))
	var ab4 = int(rand_range(0, 4))
	var ab5 = int(rand_range(0, 20))
	var ab6 = int(rand_range(0, 10))
	var ab7 = int(rand_range(0, 6))
	if ab1 == 0 or ab1 == 1 or ab1 == 2:
		Zombi_alive1()
		tot1 = int(rand_range(0, 19))
		vid1 = true
	if ab2 == 1:
		Zombi_alive2()
		tot2 = int(rand_range(0, 19))
		vid2 = true
	if ab3 == 2:
		Zombi_alive3()
		tot3 = int(rand_range(0, 19))
		vid3 = true
	if ab4 == 3:
		Zombi_alive4()
		tot4 = int(rand_range(0, 19))
		vid4 = true
	if ab5 == 4:
		Zombi_alive5()
		tot5 = int(rand_range(0, 19))
		vid5 = true
	if ab6 == 5:
		Zombi_alive6()
		tot6 = int(rand_range(0, 19))
		vid6 = true
	if ab7 == 6 or ab7 == 1 or ab7 == 3:
		Zombi_alive7()
		tot7 = int(rand_range(0, 19))
		vid7 = true
	$Timer.start(0)
	

################################################################################################################

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
func _on_Timer_timeout():
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
	elif zashel == false:
		$Timer.stop()
		print('АСТАНАВЫТЕСЬ')
		endalive = true
	zashel = false


