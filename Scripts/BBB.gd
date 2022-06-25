extends CanvasLayer
#Параметры для перезаписи сейва
var Shootingspeed = null
var Therangeofthebullet = null
var Barr1 = null
var Barr2 = null
var Barr3 = null
var Apteka = null
var Gr = null
var Ammo = null
var Map = null
var Speed = null
var HP = null
var MAXHP = null
var minus1 = null
var minus2 = null
var minus3 = null
var minus4 = null
var minus5 = null
var minus6 = null
var inc1 = null
var inc2 = null
var inc3 = null
var inc4 = null
var inc5 = null
var inc6 = null
var coast1 = null
var coast2 = null
var coast3 = null
var coast4 = null
var inc21 = null
var inc22 = null
var inc23 = null
var inc24 = null
var Bestwave = null
var end12lvl = null
var numberofwave = null
var tutorial = null

func _ready():
	load_level()
	$Pause_Menu.visible = false
	pass # Replace with function body.

var pop = 0
func _process(delta):
	if 	mojno_vkluchit_zadanine == true and $Pause_Menu.visible == false:      #####Для включения таблички с заданием после закрытия туторила при самой первой игре
			mojno_vkluchit_zadanine = false
			$Task_timer.start(1)
			
	if $Control/DeathScreen.visible == true:
		numberofwave = 0
		$Task.visible = false
		$LabelTask.visible = false
		$LabelTask2.visible = false
		$TouchScreenButton10.visible = false
		$TouchScreenButton.visible = false
		$TouchScreenButton2.visible = false
		$TouchScreenButton3.visible = false
		$TouchScreenButton4.visible = false
		$TouchScreenButton5.visible = false
		$TouchScreenButton6.visible = false
		$TouchScreenButton7.visible = false
		$TouchScreenButton8.visible = false
		$TouchScreenButton9.visible = false
		$Control/Coins.visible = false
		$Control/HealthBar.visible = false
		$Pause_Menu.visible = false
		$Pause.visible = false
		$joystick_my.visible = false
		$Control/Panel.visible = false
		$Control/Panel_GUN.visible = false
		$Control/Panel_Barricade.visible = false
		$Red.visible = false
		$Red2.visible = false
		$Red3.visible = false
		$Red4.visible = false
		$Red5.visible = false
		$Red6.visible = false
		$GunButton.visible = false
		if $Pause_Menu.visible == false and pop == 0:
			pop = pop + 1
			save_level()
			print("HARRY POTTER")
#Сохранение и загрузка
func save_level():   #######Тут только coins перезаписывать
	Fs.save_data('Player_saves.txt',{
		'Coins' : loadr.get_amount(),
		'Speed' : Speed,
		'Shootingspeed' : Shootingspeed,
		'Therangeofthebullet' : Therangeofthebullet,
		'HP' : HP,
		'MAXHP' : MAXHP,
		'Barr1' : Barr1,
		'Barr2' : Barr2,
		'Barr3' : Barr3,
		'Apteka' : Apteka,
		'Gr' : Gr,
		'Ammo' : Ammo,
		'Map' : Map,
		'Minus1' : minus1,
		'Minus2' : minus2,
		'Minus3' : minus3,
		'Minus4' : minus4,
		'Minus5' : minus5,
		'Minus6' : minus6,
		'inc1' : inc1,
		'inc2' : inc2,
		'inc3' : inc3,
		'inc4' : inc4,
		'inc5' : inc5,
		'inc6' : inc6,
		'coast1' : coast1,
		'coast2' : coast2,
		'coast3' : coast3,
		'coast4' : coast4,
		'inc21' : inc21,
		'inc22' : inc22,
		'inc23' : inc23,
		'inc24' : inc24,
		'Bestwave' : Bestwave,
		'end12lvl' : end12lvl,
		'numberofwave' : numberofwave,
		'tutorial' : tutorial
	})

onready var loadr = find_node('Coins')

func load_level():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		#loadr.set_amount(0) #Кладем ноль монеток на старте, если нет сохранений
		firstsave_level()
	else:
		#Если сохранения найдены, то кладем в Coins значение из сейвов
		loadr.set_amount(data.Coins)
		#Все данные о персонаже
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.set_item_barricade(data.Barr1, data.Barr2, data.Barr3) 
			i.set_item_more(data.Apteka, data.Gr, data.Ammo)
			i.set_speed(data.Speed)
			i.set_HP(data.HP, data.MAXHP)
		#Все данные о пуле передаются ей на прямую (в момент создания, то есть вылета из пистолета)
		#Сохраняю все остальные параметры
		Speed = data.Speed
		HP = data.HP
		MAXHP = data.MAXHP
		Shootingspeed = data.Shootingspeed
		Therangeofthebullet = data.Therangeofthebullet
		Barr1 = data.Barr1
		Barr2 = data.Barr2
		Barr3 = data.Barr3
		Apteka = data.Apteka
		Gr = data.Gr
		Ammo = data.Ammo
		Map = data.Map
		minus1 = data.Minus1
		minus2 = data.Minus2
		minus3 = data.Minus3
		minus4 = data.Minus4
		minus5 = data.Minus5
		minus6 = data.Minus6
		inc1 = data.inc1
		inc2 = data.inc2
		inc3 = data.inc3
		inc4 = data.inc4
		inc5 = data.inc5
		inc6 = data.inc6
		coast1 = data.coast1
		coast2 = data.coast2
		coast3 = data.coast3
		coast4 = data.coast4
		inc21 = data.inc21
		inc22 = data.inc22
		inc23 = data.inc23
		inc24 = data.inc24
		Bestwave = data.Bestwave
		end12lvl = data.end12lvl
		numberofwave = data.numberofwave
		tutorial = data.tutorial

#Первое создание сохранения где все по нулям!!!!!!!!!!!
func firstsave_level():
	Fs.save_data('Player_saves.txt',{
		'Coins' : 0,
		'Speed' : 450,
		'Shootingspeed' : 550,
		'Therangeofthebullet' : 400,
		'HP' : 100,
		'MAXHP' : 100,
		'Barr1' : 0,
		'Barr2' : 0,
		'Barr3' : 0,
		'Apteka' : 1,
		'Gr' : 1,
		'Ammo' : 0,
		'Map' : 1,
		'Minus1' : 100,
		'Minus2' : 100,
		'Minus3' : 100,
		'Minus4' : 100,
		'Minus5' : 100,
		'Minus6' : 100,
		'inc1' : 0,
		'inc2' : 0,
		'inc3' : 0,
		'inc4' : 0,
		'inc5' : 0,
		'inc6' : 0,
		'coast1' : 1000,
		'coast2' : 1000,
		'coast3' : 1000,
		'coast4' : 1000,
		'inc21' : 0,
		'inc22' : 0,
		'inc23' : 0,
		'inc24' : 0,
		'Bestwave' : 0,
		'end12lvl' : 0,
		'numberofwave' : 0,
		'tutorial' : 0
	})
	load_level()
	pass

func _on_Pause_pressed():
	pass

func _on_Pause_released():
	if get_tree().paused == false:
		get_tree().paused = true
		$TouchScreenButton.visible = false
		$TouchScreenButton5.visible = false
		$TouchScreenButton9.visible = false
		$Pause_Menu.visible = true
		$joystick_my.visible = false
		
		$Control/Arrow.visible = false
		$Control/Arrow2.visible = false
		
	else:
		get_tree().paused = false 
		$TouchScreenButton.visible = true
		$TouchScreenButton5.visible = true
		$TouchScreenButton9.visible = true
		$Pause_Menu.visible = false
		$joystick_my.visible = true

		$Control/Arrow.visible = true
		$Control/Arrow2.visible = true
		
		

var button = 0
onready var Buttons = get_viewport().get_node("Root/Outdoor")
#Кнопка для использования патронов 
func _on_TouchScreenButton2_pressed():
	pass # Replace with function body.
func _on_TouchScreenButton2_released():
	if $Red.visible == false:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_barr1contact(false)
				i.set_barr2contact(false)
				i.set_barr3contact(false)
				i.ShotAndBarr(true)
		$Red.visible = true
		$Red2.visible = false
		$Red3.visible = false
		$Red4.visible = false
		$Red5.visible = false
		$Red6.visible = false
		button = 3
		Buttons.set_button(3)
	else:
		$Red.visible = false
		button = 0
		Buttons.set_button(0)
		
	pass # Replace with function body.

#Для гранат
func _on_TouchScreenButton3_pressed():
	pass # Replace with function body.
func _on_TouchScreenButton3_released():
	if $Red2.visible == false:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_barr1contact(false)
				i.set_barr2contact(false)
				i.set_barr3contact(false)
				i.ShotAndBarr(true)
		$Red2.visible = true
		$Red.visible = false
		$Red3.visible = false
		$Red4.visible = false
		$Red5.visible = false
		$Red6.visible = false
		button = 2
		Buttons.set_button(2)
	else:
		$Red2.visible = false
		button = 0
		Buttons.set_button(0)
	pass # Replace with function body.

#Для аптеки
func _on_TouchScreenButton4_pressed():
	pass # Replace with function body.
func _on_TouchScreenButton4_released():
	if $Red3.visible == false:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_barr1contact(false)
				i.set_barr2contact(false)
				i.set_barr3contact(false)
				i.ShotAndBarr(true)
		$Red3.visible = true
		$Red2.visible = false
		$Red.visible = false
		$Red4.visible = false
		$Red5.visible = false
		$Red6.visible = false
		button = 1
		Buttons.set_button(1)
	else:
		$Red3.visible = false
		button = 0
		Buttons.set_button(0)
	pass # Replace with function body.



var vozleturreli = false
#Баррикады
#Кирпичная
func _on_TouchScreenButton6_pressed():
	pass # Replace with function body.
func _on_TouchScreenButton6_released():
		#Проверка стоит ли игрок за туррелью 
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		vozleturreli = i.get_vozleturreli()
		
	if vozleturreli == false:
		if $Red4.visible == false:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_barr1contact(true)
					i.set_barr2contact(false)
					i.set_barr3contact(false)
			$Red4.visible = true
			$Red2.visible = false
			$Red.visible = false
			$Red3.visible = false
			$Red5.visible = false
			$Red6.visible = false
			button = 4
			Buttons.set_button(4)
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.ShotAndBarr(false)
		else:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_barr1contact(false)
			$Red4.visible = false
			button = 0
			Buttons.set_button(0)
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.ShotAndBarr(true)
	pass # Replace with function body.

#Цепь
func _on_TouchScreenButton7_pressed():
	pass # Replace with function body.
func _on_TouchScreenButton7_released():
		#Проверка стоит ли игрок за туррелью 
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		vozleturreli = i.get_vozleturreli()
		
	if vozleturreli == false:
		if $Red5.visible == false:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_barr2contact(true)
					i.set_barr1contact(false)
					i.set_barr3contact(false)
			$Red5.visible = true
			$Red2.visible = false
			$Red.visible = false
			$Red3.visible = false
			$Red4.visible = false
			$Red6.visible = false
			button = 5
			Buttons.set_button(5)
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.ShotAndBarr(false)
		else:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_barr2contact(false)
			$Red5.visible = false
			button = 0
			Buttons.set_button(0)
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.ShotAndBarr(true)
	pass # Replace with function body.
	
#Туррель
func _on_TouchScreenButton8_pressed():
	pass # Replace with function body.
func _on_TouchScreenButton8_released():
		#Проверка стоит ли игрок за туррелью 
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		vozleturreli = i.get_vozleturreli()
		
	if vozleturreli == false:
		if $Red6.visible == false:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_barr1contact(false)
					i.set_barr2contact(false)
					i.set_barr3contact(true)
			$Red6.visible = true
			$Red2.visible = false
			$Red.visible = false
			$Red3.visible = false
			$Red4.visible = false
			$Red5.visible = false
			button = 6
			Buttons.set_button(6)
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.ShotAndBarr(false)
		else:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_barr3contact(false)
			$Red6.visible = false
			button = 0
			Buttons.set_button(0)
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.ShotAndBarr(true)
	pass # Replace with function body.

###Зажатая клавиша выстрела
func _on_TouchScreenButton_pressed():
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_turnaround(true)
	pass # Replace with function body.
#Отжатая
func _on_TouchScreenButton_released():
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_turnaround(false)
				#i.set_walking(false)
	pass # Replace with function body.


onready var panel_g = get_node("Control/Panel_GUN")
#Кнопка для переключения оружия
func _on_GunButton_pressed():
	pass # Replace with function body.
func _on_GunButton_released():
	panel_g.icon_item()
	pass # Replace with function body.



#включение выбора игры
func turnon_BIGREADBUTTON():
	$Pause.visible = false
	$BIRREADBUTTON.visible = true
	$Control.visible = false
	$Red6.visible = false
	$Red.visible = false
	$Red2.visible = false
	$Red3.visible = false
	$Red4.visible = false
	$Red5.visible = false
	$TouchScreenButton6.visible = false
	$TouchScreenButton7.visible = false
	$TouchScreenButton8.visible = false
	$TouchScreenButton4.visible = false
	$TouchScreenButton3.visible = false
	$TouchScreenButton2.visible = false
	
	$Task.visible = false
	$LabelTask.visible = false
	$LabelTask2.visible = false
	$TouchScreenButton10.visible = false
	
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		i.set_barr3contact(false)
		i.set_barr2contact(false)
		i.set_barr1contact(false)
		i.ShotAndBarr(true)
		
	button = 0
	Buttons.set_button(0)
	
func turnoff_BIGREADBUTTON():
	$Pause.visible = true
	$BIRREADBUTTON.visible = false
	$Panel_lvl.visible = false
	$Control.visible = true
	
	$TouchScreenButton6.visible = true
	$TouchScreenButton7.visible = true
	$TouchScreenButton8.visible = true
	$TouchScreenButton4.visible = true
	$TouchScreenButton3.visible = true
	$TouchScreenButton2.visible = true

	
func _on_BIRREADBUTTON_released():
	if numberofwave == 0:
		if $Panel_lvl.visible == false :
			$Panel_lvl.visible = true
			$BIRREADBUTTON.visible = false
		else:
			$Panel_lvl.visible = false
	else: 
		if $Panel_lvl2.visible == false :
			$Panel_lvl2.visible = true
			$BIRREADBUTTON.visible = false
		else:
			$Panel_lvl2.visible = false
			
func set_numberofwave1(ava):   ###Используется в меню паузы при нажатие на первую клавишу
	numberofwave = ava
	
	
	
	#########Включение туториала при первом запуске
var mojno_vkluchit_zadanine = false
func tutorial_turnon():
	get_tree().paused = true
	$Pause_Menu.visible = true
	$Control/Arrow.visible = false
	$Control/Arrow2.visible = false
	$Pause_Menu/Tutorial1.visible = true
	$Pause_Menu/Close.visible = true
	mojno_vkluchit_zadanine = true
	

#Закрытие задания
func _on_TouchScreenButton10_released():
	$Task.visible = false
	$LabelTask.visible = false
	$LabelTask2.visible = false
	$TouchScreenButton10.visible = false
	pass
#Включение задания
func Task_turnon(am):
	$LabelTask2.text = str(am)
	$Task.visible = true
	$LabelTask.visible = true
	$LabelTask2.visible = true
	$TouchScreenButton10.visible = true
	
#таймер для самого перовго включения таблички с заданием (чтобы сама включилась. вызывается в UI2)
var timer = 0
func _on_Task_timer_timeout():
	timer = timer + 1
	if timer == 2:
			Task_turnon(2)
			$Task_timer.stop()
	pass # Replace with function body.
