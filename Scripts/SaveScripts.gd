
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
var coins = null
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
func _ready():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		$Label4.text = "0"
	else:
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
		coins = data.Coins
		$Label.text = "Coins: " + str(coins)
		

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
		'numberofwave' : numberofwave

	})
	pass

