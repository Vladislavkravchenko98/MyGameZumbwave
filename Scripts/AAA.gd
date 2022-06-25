extends Node2D
var max_zombi = 2  ##Сколько Зомби добавить в самом начале
var ZmSc = preload("res://Scenes/Zombi.tscn")    #Обычный
var ZmSc2 = preload("res://Scenes/Zombi_2.tscn")  #С мозгами (мятный)
var ZmSc3 = preload("res://Scenes/Zombi_3.tscn") #Толстый
var ZmSc4 = preload("res://Scenes/Zombi_4.tscn") #С шипами
var ZmSc5 = preload("res://Scenes/Zombi_5.tscn") #Босс
var ZmSc6 = preload("res://Scenes/Zombi_6.tscn") #Без футболки
var ZmSc7 = preload("res://Scenes/Zombi_7.tscn") #Взрывающийся 


func get_zombi():
		return $Zombi
	
var numberofwave = 0
var tutorial
func _ready():
	############################################################################ Проверка есть ли  number_of_wave в сохранение 
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		max_zombi = 2
		$Tutorial.start(1)
		print('ДА ТАМ БЫЛО ПУСТО')
	else:
		numberofwave = data.numberofwave
		########## Сколько нужно убить зомби для задания
		am = numberofwave - 2
		$Task.start(1)
		#########

		if numberofwave == 0:
			max_zombi = 0
		else:
			max_zombi = numberofwave + 5
	###########################################################################
	Addzombi()
	
	
####################Номер волны (WAVE) ###################################              
#onready var Wave = get_viewport().get_node("Root/UI/Control/Wave")
####################Arrow (УКАЗАТЕЛЬ) ###################################              
onready var Arrow = get_viewport().get_node("Root/UI/Control/Arrow")
onready var Arrow2 = get_viewport().get_node("Root/UI/Control/Arrow2")
####Появление новых Зомби, если все прошлые умерли####
var allzm = 0 #Сколько зомби вживых на данный момент
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
		#Wave.set_wave(1)
		number_of_wave = number_of_wave + 1
		#max_zombi = max_zombi + 1    ### Сколько зомби добавляется
		Addzombi()
	#elif allzm == am:
		#var teleport = true
		################################################################################################Сюда вставить инфу о том что можно телепортится через UI??
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
	allzm = 0
	pl = 0
		




var born_zombie = true
func Addzombi():
	randomize()
	if number_of_wave == 1: #################################################### Туторил 
		
		if max_zombi == 2:      ######
			for i in range(max_zombi):
				var zm = ZmSc.instance()
				var a = int(rand_range(300, 9014))
				var b = int(rand_range(300, 6230))
				
				zm.position.x = a
				zm.position.y = b
				
				add_child(zm)
		else:                ###################################################### Обычная игра
			for i in range(max_zombi/5):
				var zm = ZmSc.instance()
				var a = int(rand_range(300, 9014))
				var b = int(rand_range(300, 6230))
				
				zm.position.x = a
				zm.position.y = b
				
				add_child(zm)
			for i in range(max_zombi/5):
				var zm2 = ZmSc2.instance()
				var a2 = int(rand_range(300, 9014))
				var b2 = int(rand_range(300, 6230))
				
				zm2.position.x = a2
				zm2.position.y = b2
				
				add_child(zm2)
			for i in range(max_zombi/5):
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
