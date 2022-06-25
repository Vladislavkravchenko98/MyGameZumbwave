extends Node2D


var coins = 0
func _ready():
	#Загружаем значение из сейва
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		$Coins.text = ": 0"
	else:
		#Если сохранения найдены
		#Беру все параметры
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
		coins = data.Coins
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
		$Coins.text = ": " + str(coins)
		minus1 = data.Minus1
		minus2 = data.Minus2
		minus3 = data.Minus3
		minus4 = data.Minus4
		minus5 = data.Minus5
		minus6 = data.Minus6
		#Это прогресс 
		inc1 = data.inc1
		inc2 = data.inc2
		inc3 = data.inc3
		inc4 = data.inc4
		inc5 = data.inc5
		inc6 = data.inc6
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
		#Заполняем надписи нужным текстом из сейвов
		$Label7.text = "<" + str(inc1) + "/50>"
		if inc1 >= 50:
			$Label8.visible = false
		else:
			$Label8.text = str(minus1) + "$"
			
		$Label2.text = "<" + str(inc2) + "/50>"
		if inc2 >= 50:
			$Label11.visible = false
		else:
			$Label11.text = str(minus1) + "$"
		
		$Label3.text = "<" + str(inc3) + "/20>"
		if inc3 >= 20:
			$Label12.visible = false
		else:
			$Label12.text = str(minus3) + "$"
		
		$Label4.text = "<" + str(inc4) + "/50>"
		if inc4 >= 50:
			$Label13.visible = false
		else:
			$Label13.text = str(minus4) + "$"
		
		$Label5.text = "<" + str(inc5) + "/50>"
		if inc5 >= 50:
			$Label9.visible = false
		else:
			$Label9.text = str(minus5) + "$"
		
		$Label.text = "<" + str(inc6) + "/50>"
		if inc6 >= 50:
			$Label10.visible = false
		else:
			$Label10.text = str(minus6) + "$"
		
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
var Superattackused = Superattackused
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
#Это сколько стоит
var minus1 = 200
var minus2 = 200
var minus3 = 200
var minus4 = 200
var minus5 = 200
var minus6 = 200
#Это прогресс 
var inc1 = 0
var inc2 = 0
var inc3 = 0
var inc4 = 0
var inc5 = 0
var inc6 = 0


################################################################# КНОПКИ ДЛЯ ПОКУПКИ

#1 кнопка 
func _on_TouchScreenButton_released():
	$AudioStreamPlayer.play()
	if coins >= minus1 and inc1 < 50:
		coins = coins - minus1
		minus1 = minus1+500
		inc1 = inc1 + 1
		$Label7.text = "<" + str(inc1) + "/50>"
		$Label8.text = str(minus1) + "$"
		$Coins.text = ": " + str(coins)
		Barr1 = Barr1 + 1
		save_level()
	else:
		$Warning.visible = true
		$ColorRect3.visible = true
		$Close.visible = true
#2 кнопка 
func _on_TouchScreenButton2_released():
	$AudioStreamPlayer.play()
	if coins >= minus2 and inc2 < 50:
		coins = coins - minus2
		minus2 = minus2+500
		inc2 = inc2 + 1
		$Label2.text = "<" + str(inc2) + "/50>"
		$Label11.text = str(minus2) + "$"
		$Coins.text = ": " + str(coins)
		Barr2 = Barr2 + 1
		save_level()
	else:
		$Warning.visible = true
		$ColorRect3.visible = true
		$Close.visible = true
#3 кнопка 
func _on_TouchScreenButton3_released():
	$AudioStreamPlayer.play()
	if coins >= minus3 and inc3 < 20:
		coins = coins - minus3
		minus3 = minus3+1000
		inc3 = inc3 + 1
		$Label3.text = "<" + str(inc3) + "/20>"
		$Label12.text = str(minus3) + "$"
		$Coins.text = ": " + str(coins)
		Barr3 = Barr3 + 1
		save_level()
	else:
		$Warning.visible = true
		$ColorRect3.visible = true
		$Close.visible = true
	pass # Replace with function body.
#4 кнопка 
func _on_TouchScreenButton4_released():
	$AudioStreamPlayer.play()
	if coins >= minus4 and inc4 < 50:
		coins = coins - minus4
		minus4 = minus4+1000
		inc4 = inc4 + 1
		$Label4.text = "<" + str(inc4) + "/50>"
		$Label13.text = str(minus4) + "$"
		$Coins.text = ": " + str(coins)
		Apteka = Apteka + 1
		save_level()
	else:
		$Warning.visible = true
		$ColorRect3.visible = true
		$Close.visible = true
	pass # Replace with function body.
#5 кнопка 
func _on_TouchScreenButton5_released():
	$AudioStreamPlayer.play()
	if coins >= minus5 and inc5 < 50:
		coins = coins - minus5
		minus5 = minus5+500
		inc5 = inc5 + 1
		$Label5.text = "<" + str(inc5) + "/50>"
		$Label9.text = str(minus5) + "$"
		$Coins.text = ": " + str(coins)
		Gr = Gr + 1
		save_level()
	else:
		$Warning.visible = true
		$ColorRect3.visible = true
		$Close.visible = true
	pass # Replace with function body.
#6 кнопка 
func _on_TouchScreenButton6_released():
	$AudioStreamPlayer.play()
	if coins >= minus6 and inc6 < 50:
		coins = coins - minus6
		minus6 = minus6+1000
		inc6 = inc6 + 1
		$Label.text = "<" + str(inc6) + "/50>"
		$Label10.text = str(minus6) + "$"
		$Coins.text = ": " + str(coins)
		Ammo = Ammo + 1
		save_level()
	else:
		$Warning.visible = true
		$ColorRect3.visible = true
		$Close.visible = true
	pass # Replace with function body.


#####################################################################################

#Сохранение
func save_level():  #Все остальные параметры могу сохранить в переменные из загрузки ИЛИ вытащить их из сцен
	Fs.save_data('Player_saves.txt',{
		'Coins' : coins,
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
	pass

#Кнопка закрытия меню предупреждения
func _on_Close_released():
	$Warning.visible = false
	$ColorRect3.visible = false
	$Close.visible = false



func _process(delta):
		if inc1 >= 50:
			$Label8.visible = false

		if inc2 >= 50:
			$Label11.visible = false
		
		if inc3 >= 20:
			$Label12.visible = false
		
		if inc4 >= 50:
			$Label13.visible = false
		
		if inc5 >= 50:
			$Label9.visible = false
		
		if inc6 >= 50:
			$Label10.visible = false








