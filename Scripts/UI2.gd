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



func _ready():
	load_level()
	$Pause_Menu.visible = false
	pass # Replace with function body.

var pop = 0
func _process(delta):
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
onready var Wave = get_viewport().get_node("Root/UI/Control/Wave")
func save_level():   #######Тут только coins перезаписывать
	#if Wave.get_wave() > Bestwave:
		#Bestwave = Wave.get_wave()
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
			if end12lvl == 1 and tmr_more == true:
				$SuAt.visible = true
			elif end12lvl == 1 and tmr_more == false:
				$SuAt.visible = false
				$SuAtoff.visible = true

		
		$Control/Arrow.visible = true
		$Control/Arrow2.visible = true ###
		
		

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
	
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		i.set_barr3contact(false)
		i.set_barr2contact(false)
		i.set_barr1contact(false)
		
	button = 0
	Buttons.set_button(0)
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.ShotAndBarr(true)
	
	
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
	if $Panel_lvl.visible == false:
		$Panel_lvl.visible = true
		$BIRREADBUTTON.visible = false
	else:
		$Panel_lvl.visible = false
		
		
func set_numberofwave(ioi):
	numberofwave = ioi

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
			if end12lvl == 1 and tmr_more == true:
				$SuAt.visible = true
			elif end12lvl == 1 and tmr == false:
				$SuAt.visible = false
				$SuAtoff.visible = true
		$Control/Arrow.visible = true
		$Control/Arrow2.visible = true ###
	
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
	
############## Сохранение значение о завершенном прохождении 12 волн и получении супер атаки
func End12wave():
	end12lvl = 1
	save_level()
#############Включение победы
func Winonn():
	if Rus == 1:
		$Win/Label.visible = false
		$Win/Label2.visible = false
		$Win/Labelrus.visible = true
		$Win/Label2rus.visible = true
		$Win/Label2rus2.visible = true
		$Win/Label2rus3.visible = true
		
		$Win.visible = true
		$WinExit.visible = true
	else:
		$Win/Labelrus.visible = false
		$Win/Label2rus.visible = false
		$Win/Label2rus2.visible = false
		$Win/Label2rus3.visible = false
		$Win/Label.visible = true
		$Win/Label2.visible = true
		
		$Win.visible = true
		$WinExit.visible = true

func _on_WinExit_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	pass # Replace with function body.

func WaveLabeloff():
	$Control/Wave.visible = false
	
	
####Таймер который из load_game запускает кнопку СУПЕР АТАКИ
var tmr = 9
var tmr_more = false
func _on_TimerONSUPER_timeout():
	tmr = tmr - 1
	tmr_more = false
	if Superattackused != 1:
		$SuAtoff/Label.visible = true
		$SuAtoff/Label.text = str(tmr)
	else:
		$SuAtoff/Label.visible = false
	if tmr == 0:
		$SuAtoff/Label.visible = false
		if Superattackused == 1:
			tmr_more = false
			$SuAt.visible = false
			$SuAtoff.visible = true
			$SuAtoff/Label.visible = false
			tmr = 9
			$SuAtoff/Label.text = ''
			$TimerONSUPER.stop()
		else:
			$SuAtoff/Label.visible = false
			$SuAt.visible = true
			$SuAtoff.visible = false
			tmr = 9
			$SuAtoff/Label.text = ''
			tmr_more = true
			$TimerONSUPER.stop()
	pass # Replace with function body.
	
#Ожидания для атаки перед каждой новой волной
func NewWaveSuperWait():
	tmr_more = false
	$SuAtoff/Label.visible = false
	$SuAtoff/Label.text = ''
	$SuAtoff.visible = false
	$SuAt.visible = false
	if end12lvl == 1:
		$SuAtoff.visible = true
		$SuAtoff/Label.text = str(9)
		$TimerONSUPER.start(1)
	else: 
		$SuAt.visible = false

#### Сохранение значения отключение музыки (не используется)
func Mu(ab1):
	Music = ab1

####Проверка на новый рекорд
onready var Pau = get_viewport().get_node("Root/UI/Pause_Menu")
func New_Best():
	if Wave.get_wave() > Bestwave and Wave.get_wave() <= 12:
		Bestwave = Wave.get_wave()
		save_level()
		Pau.BestRecordNew(Bestwave)

