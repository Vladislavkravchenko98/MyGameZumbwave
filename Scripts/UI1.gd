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
var Bulletspeed = null
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
var coast5 = null
var inc21 = null
var inc22 = null
var inc23 = null
var inc24 = null
var inc25 = null
var Bestwave = null
var end12lvl = null
var numberofwave = null
var Superattackused = null
var Music = null
var Indicator = null
var Rus = null
#####Добавление временного лута (который собран на карте во время игры)
var Barr1more = null
var Barr2more = null
var Barr3more = null
var Grmore = null
var Ammomore = null
var Aptekamore = null
func set_allinc():
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		Ammomore = i.get_incammo()
		Aptekamore = i.get_incapteka()
		Grmore = i.get_incgr()
		Barr1more = i.get_incbrick()
		Barr2more = i.get_incchain()
		Barr3more = i.get_incturrent()
	


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
		$SuAt.visible = false
		$SuAtoff.visible = false
		if $Pause_Menu.visible == false and pop == 0:
			pop = pop + 1
			save_level()
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
		'Bulletspeed' : Bulletspeed,
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
		'coast5' : coast5,
		'inc21' : inc21,
		'inc22' : inc22,
		'inc23' : inc23,
		'inc24' : inc24,
		'inc25' : inc25,
		'Bestwave' : Bestwave,
		'end12lvl' : end12lvl,
		'numberofwave' : numberofwave,
		'Barr1more' : Barr1more,
		'Barr2more' : Barr2more,
		'Barr3more' : Barr3more,
		'Grmore' : Grmore,
		'Ammomore' : Ammomore,
		'Aptekamore' : Aptekamore,
		'Superattackused' : Superattackused,
		'Music' : Music,
		'Indicator' : Indicator,
		'Rus' : Rus
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
			if data.numberofwave <= 0:
				i.set_item_barricade(data.Barr1, data.Barr2, data.Barr3) 
				i.set_item_more(data.Apteka, data.Gr, data.Ammo)
			else:
				i.set_item_barricade(data.Barr1more, data.Barr2more, data.Barr3more) 
				i.set_item_more(data.Aptekamore, data.Grmore, data.Ammomore)
			i.set_speed(data.Speed)
			i.set_HP(data.HP, data.MAXHP)
			i.Add_pistol(data.Shootingspeed)
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
		Bulletspeed = data.Bulletspeed
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
		coast5 = data.coast5
		inc21 = data.inc21
		inc22 = data.inc22
		inc23 = data.inc23
		inc24 = data.inc24
		inc25 = data.inc25
		Bestwave = data.Bestwave
		end12lvl = data.end12lvl
		numberofwave = data.numberofwave
		Barr1more = data.Barr1more
		Barr2more = data.Barr2more
		Barr3more = data.Barr3more
		Grmore = data.Grmore
		Ammomore = data.Ammomore
		Aptekamore = data.Aptekamore
		Superattackused = data.Superattackused
		Music = data.Music
		Indicator = data.Indicator
		Rus = data.Rus
		if end12lvl == 1:
			$SuAtoff.visible = true
			if Superattackused != 1:
				$SuAtoff/Label.visible = true
			else:
				$SuAtoff/Label.visible = false
			$TimerONSUPER.start(1)
		else: 
			$SuAt.visible = false
	pass
#Первое создание сохранения где все по нулям!!!!!!!!!!!
func firstsave_level():
	Fs.save_data('Player_saves.txt',{
		'Coins' : 0,
		'Speed' : 0,
		'Shootingspeed' : 0.9,
		'Therangeofthebullet' : 0,
		'HP' : 0,
		'MAXHP' : 0,
		'Barr1' : 0,
		'Barr2' : 0,
		'Barr3' : 0,
		'Apteka' : 1,
		'Gr' : 1,
		'Ammo' : 0,
		'Bulletspeed' : 0,
		'Minus1' : 100,
		'Minus2' : 100,
		'Minus3' : 2000,
		'Minus4' : 1000,
		'Minus5' : 100,
		'Minus6' : 1000,
		'inc1' : 0,
		'inc2' : 0,
		'inc3' : 0,
		'inc4' : 1,
		'inc5' : 1,
		'inc6' : 0,
		'coast1' : 1000,
		'coast2' : 1000,
		'coast3' : 1000,
		'coast4' : 1000,
		'coast5' : 1000,
		'inc21' : 0,
		'inc22' : 0,
		'inc23' : 0,
		'inc24' : 0,
		'inc25' : 0,
		'Bestwave' : 0,
		'end12lvl' : 0,
		'numberofwave' : 0,
		'Barr1more' : 0,
		'Barr2more' : 0,
		'Barr3more' : 0,
		'Grmore' : 0,
		'Ammomore' : 0,
		'Aptekamore' : 0,
		'Superattackused' : 0,
		'Music' : 1,
		'Indicator' : 1,
		'Rus' : 0
	})
	load_level()
	pass

func _on_Pause_pressed():
	pass

func _on_Pause_released():
	if get_tree().paused == false:
		$AudioStreamPlayer1.play()
		get_tree().paused = true
		$TouchScreenButton.visible = false
		$TouchScreenButton5.visible = false
		$TouchScreenButton9.visible = false
		$Pause_Menu.visible = true
		$joystick_my.visible = false
		$SuAt.visible = false
		$SuAtoff.visible = false
		
		$Control/Arrow.visible = false
		$Control/Arrow2.visible = false
		$Control/ArrowCastle.visible = false
		
	else:
		$AudioStreamPlayer2.play()
		get_tree().paused = false 
		$TouchScreenButton.visible = true
		$TouchScreenButton5.visible = true
		$TouchScreenButton9.visible = true
		$Pause_Menu.visible = false
		$joystick_my.visible = true
		if Superattackused == 1:
			$SuAt.visible = false
			$SuAtoff.visible = true
		else:
			if end12lvl == 1 and tmr == 0:
				$SuAt.visible = true
			elif end12lvl == 1 and tmr != 0:
				$SuAt.visible = false
				$SuAtoff.visible = true
		$Control/Arrow.visible = true
		$Control/Arrow2.visible = true
		$Control/ArrowCastle.visible = true
		
		

var button = 0
onready var Buttons = get_viewport().get_node("Root/Outdoor")
#Кнопка для использования патронов 
func _on_TouchScreenButton2_pressed():
	pass # Replace with function body.
func _on_TouchScreenButton2_released():
	"""
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
		Buttons.set_button(0)"""

		
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
	
	$Control/Coins.visible = false
	$Control/HealthBar.visible = false
	$Control/Panel.visible = false
	$Control/Panel_Barricade.visible = false
	$Control/Arrow.visible = false
	$Control/Arrow2.visible = false
	$Control/ArrowCastle.visible = false
	
	$SuAt.visible = false
	$SuAtoff.visible = false
	
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
	
	$Taskpicture.visible = false

	$LabelTaskrus.visible = false
	$LabelTaskrus2.visible = false
	$LabelTaskrus3.visible = false
	$LabelTaskrus4.visible = false
	
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
	$Panel_lvlmore.visible = false
	$La1.visible = false
	$La2.visible = false
	$Control.visible = true
	
	if Superattackused == 1:
		$SuAt.visible = false
		$SuAtoff.visible = true
	else:
		if end12lvl == 1 and tmr == 0:
			$SuAt.visible = true
		elif end12lvl == 1 and tmr != 0:
			$SuAt.visible = false
			$SuAtoff.visible = true
	
	$Control/Coins.visible = true
	$Control/HealthBar.visible = true
	$Control/Panel.visible = true
	$Control/Panel_Barricade.visible = true
	$Control/Arrow.visible = true
	$Control/Arrow2.visible = true
	$Control/ArrowCastle.visible = true
	
	$TouchScreenButton6.visible = true
	$TouchScreenButton7.visible = true
	$TouchScreenButton8.visible = true
	$TouchScreenButton4.visible = true
	$TouchScreenButton3.visible = true
	$TouchScreenButton2.visible = true
		
	button = 0
	Buttons.set_button(0)

	
func _on_BIRREADBUTTON_released():
	$AudioStreamPlayer2.play()
	if numberofwave == 0:
		if $Panel_lvl.visible == false :
			$Panel_lvl.visible = true
			$BIRREADBUTTON.visible = false
			if end12lvl == 1:
				$La1.visible = true
				$La2.visible = true
		else:
			$Panel_lvl.visible = false
			$La1.visible = false
			$La2.visible = false
	elif numberofwave > 0: 
		if zadan == true:
			if $Panel_lvlmore.visible == false :
				$Panel_lvlmore.visible = true
				$BIRREADBUTTON.visible = false
			else:
				$Panel_lvlmore.visible = false
		else:
			get_tree().paused = true
			$Taskpicture.visible = true
			if Rus == 1:
				$LabelTaskrus.visible = true
				$LabelTaskrus2.visible = true
				$LabelTaskrus3.visible = true
				$LabelTaskrus4.visible = true
			else:
				$LabelTask.visible = true
			$LabelTask2.visible = true
			$TouchScreenButton10.visible = true
			
func set_numberofwave1(ava):   ###Используется в меню паузы при нажатие на первую клавишу
	numberofwave = ava
	
	
	
	#########Включение туториала при первом запуске
var mojno_vkluchit_zadanine = false
func tutorial_turnon():
	get_tree().paused = true
	$Pause_Menu.visible = true
	$Control/Arrow.visible = false
	$Control/Arrow2.visible = false
	if Rus == 1:
		$Pause_Menu/Tutorial2.visible = true
	else:
		$Pause_Menu/Tutorial1.visible = true
	$Pause_Menu/Close.visible = true
	mojno_vkluchit_zadanine = true
	

#Закрытие задания
func _on_TouchScreenButton10_released():
	$AudioStreamPlayer1.play()
	
	$joystick_my.visible = true
	$TouchScreenButton.visible = true
	$TouchScreenButton5.visible = true
	$TouchScreenButton9.visible = true
	
	$Taskpicture.visible = false
	
	$LabelTaskrus.visible = false
	$LabelTaskrus2.visible = false
	$LabelTaskrus3.visible = false
	$LabelTaskrus4.visible = false
	
	$LabelTask.visible = false
	$LabelTask2.visible = false
	$Youcancontinue.visible = false
	

	$Youcancontinuerus.visible = false
	$Youcancontinuerus2.visible = false
	$Youcancontinuerus3.visible = false
	$Youcancontinuerus4.visible = false
	$Youcancontinuerus5.visible = false
	$Youcancontinuerus6.visible = false
	$Youcancontinuerus7.visible = false
			
	$FirstYoucancontinue.visible = false
	
	$Youcancontinuerus.visible = false
	$Youcancontinuerus2.visible = false
	$Youcancontinuerus3.visible = false
	$Youcancontinuerus4.visible = false
	$Youcancontinuerus5.visible = false
	$Youcancontinuerus6.visible = false
	$Youcancontinuerus7.visible = false
	
	$FS2.visible = false
	$TouchScreenButton10.visible = false
	$Pause_Menu.visible = false ######### Чтобы одновременно не вылезало
	$Pause.visible = true
	get_tree().paused = false
	pass
#Включение задания
func Task_turnon(am):
	$Pause_Menu.visible = false ######### Чтобы одновременно не вылезало
	$Pause.visible = false
	get_tree().paused = true
	$LabelTask2.text = str(am)
	$Taskpicture.visible = true
	if Rus == 1:
		$LabelTaskrus.visible = true
		$LabelTaskrus2.visible = true
		$LabelTaskrus3.visible = true
		$LabelTaskrus4.visible = true
	else:
		$LabelTask.visible = true
	$LabelTask2.visible = true
	$TouchScreenButton10.visible = true

#Включение таблички, что задание выполено 
func Continue_turnon():
	$Pause.visible = false
	if numberofwave > 0:
		$Pause_Menu.visible = false ######### Чтобы одновременно не вылезало
		get_tree().paused = true
		$Taskpicture.visible = true
		if Rus == 1:
			$Youcancontinuerus.visible = true
			$Youcancontinuerus2.visible = true
			$Youcancontinuerus3.visible = true
			$Youcancontinuerus4.visible = true
			$Youcancontinuerus5.visible = true
			$Youcancontinuerus6.visible = true
			$Youcancontinuerus7.visible = true
		else:
			$Youcancontinue.visible = true
		$TouchScreenButton10.visible = true
	else: 
		$Pause_Menu.visible = false ######### Чтобы одновременно не вылезало
		get_tree().paused = true
		$Taskpicture.visible = true
		if Rus == 1:
			$Youcancontinuerus2.visible = true
			$Youcancontinuerus3.visible = true
			$Youcancontinuerus4.visible = true
			$Youcancontinuerus5.visible = true
			$Youcancontinuerus6.visible = true
			$Youcancontinuerus7.visible = true
		else:
			$FS2.visible = true
		$TouchScreenButton10.visible = true

	
#Включение таблички в самый первый раз, что задание выполено 
func FirstContinue_turnon():
	$Pause_Menu.visible = false ######### Чтобы одновременно не вылезало
	$Pause.visible = false
	get_tree().paused = true
	$Taskpicture.visible = true
	if Rus == 1:
		$Youcancontinuerus.visible = true
		$Youcancontinuerus2.visible = true
		$Youcancontinuerus3.visible = true
		$Youcancontinuerus4.visible = true
		$Youcancontinuerus5.visible = true
		$Youcancontinuerus6.visible = true
		$Youcancontinuerus7.visible = true
	else:
		$FirstYoucancontinue.visible = true
	$TouchScreenButton10.visible = true
	
#таймер для самого перовго включения таблички с заданием (чтобы сама включилась. вызывается в UI2)
var timer = 0
func _on_Task_timer_timeout():
	timer = timer + 1
	if timer == 2:
			$Pause_Menu.visible = false ######### Чтобы одновременно не вылезало
			Task_turnon(2)
			$Task_timer.stop()
	pass # Replace with function body.

#Выполенно ли задание по убийству зомбарей
var zadan = false
func zadanie_done(non):
	zadan = non
	
	
####Функция для паузы еще одной
func Button_pause():
	if get_tree().paused == false:
		get_tree().paused = true
		$TouchScreenButton.visible = false
		$TouchScreenButton5.visible = false
		$TouchScreenButton9.visible = false
		$Pause_Menu.visible = true
		$joystick_my.visible = false
		$SuAt.visible = false
		
		$Control/Arrow.visible = false
		$Control/Arrow2.visible = false
		$Control/ArrowCastle.visible = false
		
	else:
		get_tree().paused = false 
		$TouchScreenButton.visible = true
		$TouchScreenButton5.visible = true
		$TouchScreenButton9.visible = true
		$Pause_Menu.visible = false
		$joystick_my.visible = true
		if Superattackused == 1:
			$SuAt.visible = false
			$SuAtoff.visible = true
		else:
			if end12lvl == 1 and tmr == 0:
				$SuAt.visible = true
			elif end12lvl == 1 and tmr != 0:
				$SuAt.visible = false
				$SuAtoff.visible = true

		$Control/Arrow.visible = true
		$Control/Arrow2.visible = true
		$Control/ArrowCastle.visible = true


######## Функция для СУПЕР АТАКИ
func SupperA():
	Superattackused = 1
	save_level()
	get_tree().paused = true
	$AnimSuperAttack.visible = true
	$AnimSuperAttack.play("SuperAttack")
	$TimeSuperA.start(1)
	
var times = 0
func _on_TimeSuperA_timeout():
	times = times + 1
	if times == 3:
		get_tree().paused = false
		$AnimSuperAttack.visible = false
		$AnimSuperAttack.stop()
		$TimeSuperA.stop()
		for i in get_tree().get_nodes_in_group(GlobalVars.zombi_group):  # Проверка сколько зомби в живых
			i.kill_super()
		times = 0
		$Pause.visible = true
	pass # Replace with function body.

#Клавиша атаки нажата
func _on_SuAt_released():
	SupperA()
	$Pause.visible = false
	$SuAt.visible = false
	$SuAtoff.visible = true
	pass # Replace with function body.

####Таймер который из load_game запускает кнопку СУПЕР АТАКИ
var tmr = 3
func _on_TimerONSUPER_timeout():
	tmr = tmr - 1
	if Superattackused != 1:
		$SuAtoff/Label.text = str(tmr)
	else:
		$SuAtoff/Label.visible = false
	if tmr == 0:
		$SuAtoff/Label.visible = false
		if Superattackused == 1:
			$SuAt.visible = false
			$SuAtoff.visible = true
			$SuAtoff/Label.visible = false
			tmr = 0
			$TimerONSUPER.stop()
		else:
			$SuAt.visible = true
			$SuAtoff.visible = false
			tmr = 0
		$TimerONSUPER.stop()
	pass # Replace with function body.
	
	
#######ИНформация что обучение пройдено
func End_Tutorial():
	Music = 0
	save_level()
	
	
	
