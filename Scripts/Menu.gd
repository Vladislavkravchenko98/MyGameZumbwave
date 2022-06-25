extends Control
#Параметры для перезаписи сейва

onready var mu = GlobalMusic

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
var numberofwave = 0
var Barr1more = 0
var Barr2more = 0
var Barr3more = 0
var Grmore = 0
var Ammomore = 0
var Aptekamore = 0
var coins = null
var Superattackused = 0
var Music = null
var Indicator = null
var Rus = null

#Сохранение и загрузка
func save_level():   
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

func _ready():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		firstsave_level()
	else:
		load_level()
	pass



func language_switch():
	if Rus == 1:
		$Button/Label.visible = false
		$Button2/Label.visible = false
		$Best_record/Label.visible = false
		$Best_record/Label2.visible = false
		$Best_record/Label3.visible = false
		$Buttons/Label.visible = false
		
		$Button/Labelrus.visible = true
		$Button2/Labelrus.visible = true
		$Best_record/Labelrus.visible = true
		$Best_record/Label2rus.visible = true
		$Best_record/Label3rus.visible = true
		$Buttons/Labelrus.visible = true
	else: 
		$Button/Labelrus.visible = false
		$Button2/Labelrus.visible = false
		$Best_record/Labelrus.visible = false
		$Best_record/Label2rus.visible = false
		$Best_record/Label3rus.visible = false
		$Buttons/Labelrus.visible = false
		
		$Button/Label.visible = true
		$Button2/Label.visible = true
		$Best_record/Label.visible = true
		$Best_record/Label2.visible = true
		$Best_record/Label3.visible = true
		$Buttons/Label.visible = true

func _on_Best_record_released():
	#$Best_record/AudioStreamPlayer.play()
	#get_tree().change_scene("res://Scenes/Donation.tscn")
	pass # Replace with function body.


func _on_Button_pressed():
	if Rus == 1:
		get_tree().change_scene("res://Scenes/Optionsrus.tscn")
	else:
		get_tree().change_scene("res://Scenes/Options.tscn")
	pass # Replace with function body.


func _on_RusLng_released():
	Rus = 1
	language_switch()
	save_level()
	pass # Replace with function body.


func _on_EngLng_released():
	Rus = 0
	language_switch()
	save_level()
	pass # Replace with function body.
	
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





func load_level():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		print('empty')
	else:
		#Склонения на русском
		if data.Bestwave <= 20:
			if data.Bestwave == 0 or data.Bestwave >= 5:
				$Best_record/Label3rus.rect_position.x = 328.5
				$Best_record/Label3rus.text = "волн" 
			elif data.Bestwave == 1:
				$Best_record/Label3rus.rect_position.x = 313.7
				$Best_record/Label3rus.text = "волна" 
			elif data.Bestwave >= 2 and data.Bestwave <= 4:
				$Best_record/Label3rus.rect_position.x = 310.74
				$Best_recordLabel3rus.text = "волны" 
		else:
			if int(data.Bestwave) % 10 == 1 or int(data.Bestwave) % 100 == 1:
				$Best_record/Label3rus.rect_position.x = 313.7
				$Best_record/Label3rus.text = "волна" 
			elif int(data.Bestwave) % 10 == 2 or int(data.Bestwave) % 10 == 3 or int(data.Bestwave) % 10 == 4 or int(data.Bestwave) % 100 == 2 or int(data.Bestwave) % 100 == 3 or int(data.Bestwave) % 100 == 4:
				$Best_record/Label3rus.rect_position.x = 310.74
				$Best_record/Label3rus.text = "волны" 
			else: 
				$Best_record/Label3rus.rect_position.x = 328.5
				$Best_record/Label3rus.text = "волн" 
				
		#Если сохранения найдены
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
		coins = data.Coins
		Bestwave = data.Bestwave
		if Bestwave == 1:
			$Best_record/Label2rus.rect_position.x = 401
		elif Bestwave >=2 and Bestwave <=9:
			$Best_record/Label2rus.rect_position.x = 389
		elif Bestwave >= 10 and Bestwave < 100 :
			#var posforlabel = 
			$Best_record/Label2.rect_position.x = $Best_record/Label2.rect_position.x - 25
			$Best_record/Label2rus.rect_position.x = 378
		elif Bestwave >= 100:
			$Best_record/Label2.rect_position.x = $Best_record/Label2.rect_position.x - 50
			$Best_record/Label2rus.rect_position.x = 359
		$Best_record/Label2.text = str(Bestwave)
		$Best_record/Label2rus.text = str(Bestwave)
		end12lvl = data.end12lvl
		Music = data.Music
		Indicator = data.Indicator
		Rus = data.Rus
		language_switch()
		save_level()
	pass
	
	
