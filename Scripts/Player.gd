extends "res://Scripts/Men2D.gd"
var inventory = {}   ##Интвентарь
onready var ui = get_viewport().get_node("Root/UI/Control")   ##Тут ссылаемся на интерфейс
onready var ui1 = get_viewport().get_node("Root/UI/Control/HealthBar")  ######################## NEW HP BAR (Улучшенный хп бар с жизнями)
var inc = 0
const PLASMA = preload("res://Scenes/Plasma.tscn")
const PLASMA2 = preload("res://Scenes/PlasmaL.tscn")
const PLASMA3 = preload("res://Scenes/PlasmaD.tscn")
const PLASMA4 = preload("res://Scenes/PlasmaU.tscn")

# Called when the node enters the scene tree for the first time.
var x_first_ammo = 10 ###Сколько всего патронов 
func _ready():
	#Для нормального начала
	inc = 2
	
	#Кладу предметы в первую Panel, чтобы запомнились их положения
	#$TimerItem.start(0)
	
	#Отключаю спрайт броска гранаты и турели 
	$Arm_Left.visible = false
	$Arm_Right.visible = false
	$Arm_Down.visible = false
	
	$Turrent.visible = false
	$Turrent_R.visible = false
	$Turrent_D.visible = false
	$Turrent_U.visible = false
	
	self.hp = 100
	speed = 400
	set_start_hp(self.hp, self.max_hp)
	original_hp = self.hp
	add_to_group(GlobalVars.entity_group)
	#############################################################################  Про HP
	ui1.set_start_hp(self.hp, self.max_hp)
	#########Сколько патронов изначально в магазине + сколько всего патронов
	bu.set_amount(20, x_first_ammo)
	#########Сколько сначала баррикад
	#set_item_barricade(2, 2, 2)
	
	
var Bar = true   #Переменная для включения Health_Bara 
signal on_death

###Функция чтобы не разворачиваться во время стрельбы
var turnaround = false
var walking = false
var firstvariable = 0
func set_turnaround(a):
	turnaround = a
func set_walking(b):
	walking = b
###Функция чтобы понимать с каким оружием должна быть моделька персонажа
var model_gun = 1
var ShotAndGunvalue = true
func gun_model(a, b):
	model_gun = a
	ShotAndGunvalue = b
	
	
var k = false
var original_hp = self.hp
func _process(delta):
	####Проверка уменьшились ли hp, чтобы сделать персонажа красным   	$anim.modulate= Color(1, 0.0, 0.0, 1)
	#if self.hp < original_hp:
		#$AudioDamage.play()
		#$anim.modulate= Color(1, 0.0, 0.0, 1)
		#$Animated.modulate= Color(1, 0.0, 0.0, 1)
		#$AnimatedSprite.modulate= Color(1, 0.0, 0.0, 1)
		#$Arm_Down.modulate= Color(1, 0.0, 0.0, 1)
		#$Arm_Left.modulate= Color(1, 0.0, 0.0, 1)
		#$Arm_Right.modulate= Color(1, 0.0, 0.0, 1)
		#$Turrent.modulate= Color(1, 0.0, 0.0, 1)
		#$Turrent_R.modulate= Color(1, 0.0, 0.0, 1)
		#$Turrent_U.modulate= Color(1, 0.0, 0.0, 1)
		#$Turrent_D.modulate= Color(1, 0.0, 0.0, 1)
		#original_hp = self.hp
		#$REDHPTIMER.start(0.3)
	####
	if turnaround == true and walking == false:
		firstvariable = 1
	elif walking == true and turnaround == false:
		firstvariable = 2
	elif turnaround == false and walking == false:
		firstvariable = 0
	#############################################
	#Barr1
	if(t == true and inc != b): ####Для баррикад                                    #Barrconnect.set_inc(inc)
		Barrconnect.set_barr1contact(false)
		Barrconnect.set_barr1contact(true)
	#Barr2
	if(t2 == true and inc != b2): 
		Barrconnect2.set_barr2contact(false)
		Barrconnect2.set_barr2contact(true)
	#Barr3
	if(t3 == true and inc != b3): 
		Barrconnect3.set_barr3contact(false)
		Barrconnect3.set_barr3contact(true)
	####################################### Добавление первоначального лута
	#if k == false :
		#set_item_more()
		#k = true
	#######################################
	ui1.update_hp(self.hp)
	if self.hp <= 0:
		emit_signal("on_death")
		queue_free()
	var velocity = Vector2()
	if model_gun == 1:
		speed = speedmore
		BitaorBarricada = false
		if vozleturreli == false:
			$Animated.visible = false
			$anim.visible = true
		if Input.is_action_pressed("up") and firstvariable == 2:
			$Arm_Left.visible = false
			$Arm_Right.visible = false
			$Arm_Down.visible = false
			inc = 0
			velocity.y -= speed
			$anim.play("U")
			inc = 1
		elif Input.is_action_pressed("down") and firstvariable == 2:
			$Arm_Left.visible = false
			$Arm_Right.visible = false
			inc = 0
			velocity.y += speed
			$anim.play("D")
			inc = 2
		elif Input.is_action_pressed("left") and firstvariable == 2:
			$Arm_Right.visible = false
			$Arm_Down.visible = false
			inc = 0
			velocity.x -= speed
			$anim.play("L")
			inc = 3
		elif Input.is_action_pressed("right") and firstvariable == 2:
			$Arm_Left.visible = false
			$Arm_Down.visible = false
			inc = 0
			velocity.x += speed
			$anim.play("R")
			inc = 4
		elif Input.is_action_pressed("up") and firstvariable == 1:  ######### Хотьба при зажатой клавише стрельбы
			inc = 0
			velocity.y -= speed
			$anim.play("TurnU")
			inc = 2
		elif Input.is_action_pressed("down") and firstvariable == 1:
			inc = 0
			velocity.y += speed
			$anim.play("TurnD")
			inc = 1
		elif Input.is_action_pressed("left") and firstvariable == 1:
			inc = 0
			velocity.x -= speed
			$anim.play("TurnL")
			inc = 4
		elif Input.is_action_pressed("right") and firstvariable == 1:
			inc = 0
			velocity.x += speed
			$anim.play("TurnR")
			inc = 3
		else:
			if inc == 1:
				velocity.x = 0
				velocity.y = 0
				$anim.play("idleU")
			if inc == 2:
				velocity.x = 0
				velocity.y = 0
				$anim.play("idleD")
			if inc == 3:
				velocity.x = 0
				velocity.y = 0
				$anim.play("idleL")
			if inc == 4:
				velocity.x = 0
				velocity.y = 0
				$anim.play("idleR")
	elif model_gun == 0:
		speed = speedmore + 100
		BitaorBarricada = true
		if vozleturreli == false:
			$Animated.visible = false
			$anim.visible = true
		if Input.is_action_pressed("up") and firstvariable == 2:
			inc = 0
			velocity.y -= speed
			$anim.play("HandU")
			inc = 1
		elif Input.is_action_pressed("down") and firstvariable == 2:
			inc = 0
			velocity.y += speed
			$anim.play("HandD")
			inc = 2
		elif Input.is_action_pressed("left") and firstvariable == 2:
			inc = 0
			velocity.x -= speed
			$anim.play("HandL")
			inc = 3
		elif Input.is_action_pressed("right") and firstvariable == 2:
			inc = 0
			velocity.x += speed
			$anim.play("HandR")
			inc = 4
		else:
			if inc == 1:
				velocity.x = 0
				velocity.y = 0
				$anim.play("HandidleU")
			if inc == 2:
				velocity.x = 0
				velocity.y = 0
				$anim.play("HandidleD")
			if inc == 3:
				velocity.x = 0
				velocity.y = 0
				$anim.play("HandidleL")
			if inc == 4:
				velocity.x = 0
				velocity.y = 0
				$anim.play("HandidleR")
	elif model_gun == 2 and lol == false:
		speed = speedmore
		BitaorBarricada = true
		if vozleturreli == false:
			$Animated.visible = true
			$anim.visible = false
		if Input.is_action_pressed("up") and firstvariable == 2:
			inc = 0
			velocity.y -= speed
			$Animated.play("U")
			inc = 1
		elif Input.is_action_pressed("down") and firstvariable == 2:
			inc = 0
			velocity.y += speed
			$Animated.play("D")
			inc = 2
		elif Input.is_action_pressed("left") and firstvariable == 2:
			inc = 0
			velocity.x -= speed
			$Animated.play("L")
			inc = 3
		elif Input.is_action_pressed("right") and firstvariable == 2:
			inc = 0
			velocity.x += speed
			$Animated.play("R")
			inc = 4
		else:
			if inc == 1:
				velocity.x = 0
				velocity.y = 0
				$Animated.play("idleU")
			if inc == 2:
				velocity.x = 0
				velocity.y = 0
				$Animated.play("idleD")
			if inc == 3:
				velocity.x = 0
				velocity.y = 0
				$Animated.play("idleL")
			if inc == 4:
				velocity.x = 0
				velocity.y = 0
				$Animated.play("idleR")
	Barrconnect.set_inc(inc)
	Barrconnect2.set_inc(inc)
	Barrconnect3.set_inc(inc)
	
	move_and_slide(velocity)
	position.x = clamp(position.x, 100, 9563)
	position.y = clamp(position.y, 0, 6380)
	
	if Bar == true:                                        # Для включения Health_Bar в самом начале игры 
		ui.toggle_inventory(inventory)
		Bar = false
		
	if inc_ammo > 0 and x_first_ammo == 0 and number_of_bullets and all_end_shoot == true:
		reload_more()
	
	
	################################# Выстрел ###################################
var allow_shoot = true   ###Переменная разрешающая стрелять (нужна чтобы нельзя было делать сразу несколько выстрелов подряд)
var number_shoot = true ###Переменная разрешающая стрелять (нужна когда значения пулек 0/0)
var time_shoot = 0.9  ####Через какое время можно снова стрелять 
var all_end_shoot = false  ####Переменная говорящая о том, что пули закончились и магазина точно нет
var BitaorBarricada = false #Перменная говорящая есть ли в руках у игрока бита или баррикада

onready var bu = get_viewport().get_node("Root/UI/Control/Panel_GUN")
var number_of_bullets = 20 #Количетсво пуль

###Функция отвечающая за возможность увеличивать скорость стрелбы из других сцен
func Add_pistol(speed_shoot):
	time_shoot = speed_shoot

var lol = false
func Shot():
	if model_gun == 1:
		if allow_shoot == true and number_shoot == true and ShotAndBarrvalue == true and ShotAndGunvalue == true:
			if inc == 4:
				var plasma = PLASMA.instance()
				plasma.global_position = $Position2D.position + position
				get_parent().add_child(plasma)
				allow_shoot = false
				$AllowShoot.start(time_shoot)   ###Таймер, что можно стрелять только спустя какое-то время (ниже для всех остальных позиций игрока)           
			elif inc == 3:
				var plasma2 = PLASMA2.instance()
				plasma2.global_position = $Position2D2.position + position
				get_parent().add_child(plasma2)
				allow_shoot = false
				$AllowShoot.start(time_shoot)
			elif inc == 2:
				var plasma3 = PLASMA3.instance()
				plasma3.global_position = $Position2D3.position + position
				get_parent().add_child(plasma3)
				allow_shoot = false
				$AllowShoot.start(time_shoot)
			elif inc == 1:
				var plasma4 = PLASMA4.instance()
				plasma4.global_position = $Position2D4.position + position
				get_parent().add_child(plasma4)
				allow_shoot = false
				$AllowShoot.start(time_shoot)
			else:
				var plasma3 = PLASMA3.instance()
				plasma3.global_position = $Position2D3.position + position
				get_parent().add_child(plasma3)
				allow_shoot = false
				$AllowShoot.start(time_shoot)
			$AudioShot.play()	
				####Уменьшения числа патронов в UI####
			
			if number_of_bullets - 1 != 0 and number_of_bullets > 0: 
				number_of_bullets = number_of_bullets - 1
				bu.set_amount(number_of_bullets, x_first_ammo)
			elif number_of_bullets - 1 == 0 and x_first_ammo >= 20:
				number_of_bullets = number_of_bullets - 1
				bu.set_amount(number_of_bullets, x_first_ammo)
				x_first_ammo = x_first_ammo - 20
				number_of_bullets = 20
				bu.set_amount(number_of_bullets, x_first_ammo)
			elif number_of_bullets - 1 == 0 and x_first_ammo < 20 and x_first_ammo > 0:
				number_of_bullets = x_first_ammo
				x_first_ammo = 0
				bu.set_amount(number_of_bullets, x_first_ammo)
			elif number_of_bullets - 1 == 0 and x_first_ammo == 0:
				bu.set_amount(0, 0)
				number_shoot = false
				if inc_ammo > 0:
					x_first_ammo = 30
					number_of_bullets = 20
					inc_ammo = inc_ammo - 1
					if yoy1 in inventory.keys():  #Если есть в инвентаре Ammo, то уменьшаем значение в луте и добавляем в UI значение
						inventory[yoy1] -= tot1.get_amount()
						bu.set_amount(0, x_first_ammo)
					ui.update_inventory(inventory)
					number_shoot = true
					bu.set_amount(number_of_bullets, x_first_ammo)
				else:
					all_end_shoot = true
	#Удар битой (тут используются переменные lol, truelol и таймеры Timerlol, Timertruelol)
	elif model_gun == 2 and lol_true == true:
		#$Animated.visible = false
		lol = true  #Запрет на смену анимации
		lol_true = false #Нельзя сразу снова бить битой
		#$AnimatedSprite.visible = true
		if inc == 4:
			varBitaR.bitaon(true)
			$Animated.play("StrikeR")
			$Timerlol.start(0.2)
		elif inc == 3:
			varBitaL.bitaon(true)
			$Animated.play("StrikeL")
			$Timerlol.start(0.2)
		elif inc == 2:
			varBitaD.bitaon(true)
			$Animated.play("StrikeD")
			$Timerlol.start(0.2)
		elif inc == 1:
			varBitaU.bitaon(true)
			$Animated.play("StrikeU")
			$Timerlol.start(0.4)
		$Timerloltrue.start(0.5)
var lol_true = true #Разрешает снова бить
onready var varBitaD = get_node("BitaD")
onready var varBitaU = get_node("BitaU")
onready var varBitaL = get_node("BitaL")
onready var varBitaR = get_node("BitaR")

###Функция для того, чтобы проверять каждый раз не поднял ли 
###игрок после того как потратил все пули новый магазин
func reload_more():
	if inc_ammo > 0:
				x_first_ammo = 30
				number_of_bullets = 20
				inc_ammo = inc_ammo - 1
				if yoy1 in inventory.keys():  
					inventory[yoy1] -= tot1.get_amount()
					bu.set_amount(0, x_first_ammo)
				ui.update_inventory(inventory)
				number_shoot = true
				bu.set_amount(number_of_bullets, x_first_ammo)
	all_end_shoot = false
	
############################ Стрельба из ТУРЕЛИ #################################
var direction = 0
var vozleturreli = false #Переменная чтобы знать за турелью игрок или нет. Если за турелью, то отмена анимаций 
func endless_shooting_L():
	direction = 3
	vozleturreli = true
	$anim.visible = false
	$Animated.visible = false
	$Turrent.visible = true

func endless_shooting_R():
	vozleturreli = true
	direction = 4
	$anim.visible = false
	$Animated.visible = false
	$Turrent_R.visible = true

func endless_shooting_U():
	vozleturreli = true
	direction = 1
	$anim.visible = false
	$Animated.visible = false
	$Turrent_U.visible = true

func endless_shooting_D():
	vozleturreli = true
	direction = 2
	$anim.visible = false
	$Animated.visible = false
	$Turrent_D.visible = true

	
	
func endless_shooting_turnoff():
	$Turrent.visible = false
	$Turrent_R.visible = false
	$Turrent_D.visible = false
	$Turrent_U.visible = false
	$anim.visible = true
	direction = 0
	vozleturreli = false

func Shot_Turrent():
	if direction == 4:
		var plasma2 = PLASMA.instance()
		var plasma3 = PLASMA.instance()
		var plasma4 = PLASMA.instance()
		#plasma2.global_position = $Turrent_R1.position + position
		plasma3.global_position = $Turrent_R2.position + position
		#plasma4.global_position = $Turrent_R3.position + position
		get_parent().add_child(plasma2)
		get_parent().add_child(plasma3)
		get_parent().add_child(plasma4)
	elif direction == 3:
		var plasma2 = PLASMA2.instance()
		var plasma3 = PLASMA2.instance()
		var plasma4 = PLASMA2.instance()
		#plasma2.global_position = $Turrent_L1.position + position
		plasma3.global_position = $Turrent_L2.position + position
		#plasma4.global_position = $Turrent_L3.position + position
		get_parent().add_child(plasma2)
		get_parent().add_child(plasma3)
		get_parent().add_child(plasma4)
	elif direction == 2:
		var plasma2 = PLASMA3.instance()
		var plasma3 = PLASMA3.instance()
		var plasma4 = PLASMA3.instance()
		#plasma2.global_position = $Turrent_D1.position + position
		plasma3.global_position = $Turrent_D2.position + position
		#plasma4.global_position = $Turrent_D3.position + position
		get_parent().add_child(plasma2)
		get_parent().add_child(plasma3)
		get_parent().add_child(plasma4)
	elif direction == 1:
		var plasma2 = PLASMA4.instance()
		var plasma3 = PLASMA4.instance()
		var plasma4 = PLASMA4.instance()
		#plasma2.global_position = $Turrent_U1.position + position
		plasma3.global_position = $Turrent_U2.position + position
		#plasma4.global_position = $Turrent_U3.position + position
		get_parent().add_child(plasma2)
		get_parent().add_child(plasma3)
		get_parent().add_child(plasma4)
	#$AudioShot.play()
	#else:
		#var plasma3 = PLASMA3.instance()
		#plasma3.global_position = $Position2D3.position + position
		#get_parent().add_child(plasma3)
	

########################### Выброс гранаты ####################################
const GR = preload("res://Scenes/Gr.tscn")
const GR2 = preload("res://Scenes/GrLeft.tscn")
const GR3 = preload("res://Scenes/GrDown.tscn")
const GR4 = preload("res://Scenes/GrUp.tscn")
func Gr():
	if (inc_gr > 0 and ShotAndBarrvalue == true and ShotAndGunvalue == true and vozleturreli == false):
		if inc == 4:
			$Arm_Right.visible = true 
			var gr = GR.instance()
			gr.global_position = $PR.position + position
			get_parent().add_child(gr)         
		elif inc == 3:
			$Arm_Left.visible = true 
			var gr2 = GR2.instance()
			gr2.global_position = $PL.position + position
			get_parent().add_child(gr2)
		elif inc == 2:
			$Arm_Down.visible = true 
			var gr3 = GR3.instance()
			gr3.global_position = $PD.position + position
			get_parent().add_child(gr3)
		elif inc == 1:
			var gr4 = GR4.instance()
			gr4.global_position = $PU.position + position
			get_parent().add_child(gr4)
		else:
			var gr3 = GR3.instance()
			gr3.global_position = $Position2D3.position + position
			get_parent().add_child(gr3)
		$Arm.start(0.2)
		inc_gr = inc_gr - 1
		if yoy2 in inventory.keys():  #Если есть в инвентаре граната, то при использование уменьшаем ее кол-во на 1 в инвентаре 
			inventory[yoy2] -= tot2.get_amount()
		ui.update_inventory(inventory)
	
########################### Использование аптечки ####################################
onready var item_more = preload("res://Scenes/InventItem.tscn")
var inc_apteka = 0

var yoy 
var tot
func Healthmore():
	if inc_apteka > 0 and self.hp < self.max_hp:
		reduce_hp_more(20)
		inc_apteka = inc_apteka - 1
		
		if yoy in inventory.keys():  #Если есть в инвентаре аптека, то при нажатие "H" уменьшаем ее кол-во на 1 в инвентаре 
			inventory[yoy] -= tot.get_amount()
		ui.update_inventory(inventory)
########################### Использование Ammo и Gr ####################################
var inc_ammo = 0
var yoy1 
var tot1

var inc_gr = 0
var yoy2 
var tot2  
### баррикады
var inc_brick = 0 
var inc_chain = 0 
var inc_turrent = 0
############################### Подбор предметов ######################################
var items = 0
func pick(item):
	var it = item.get_item()
	if it == "Apteka":             ##Проверка равен ли поднятый элемент Апетеке и др.
		inc_apteka = inc_apteka + 1
		yoy = it
		tot = item
	elif it == "Ammo":
		inc_ammo = inc_ammo + 1
		yoy1 = it
		tot1 = item
	elif it == "Gr":
		inc_gr = inc_gr + 1
		yoy2 = it
		tot2 = item
		
	if it in inventory.keys():  #Если есть в инвентаре
		inventory[it] += item.get_amount()
	else:                       #Если нет в инвентаре 
		 inventory[it] = item.get_amount()
	ui.update_inventory(inventory)
	
	### Функция по обработке ввода  (Если нажимаем клавишу "i", то открывается панель с лутом)
func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		ui.toggle_inventory(inventory)
#############Добавление баррикад в лут
onready var Panel_Bar = get_viewport().get_node("Root/UI/Control/Panel_Barricade")

func pick_brick(item):
	inc_brick = inc_brick + 1
	Panel_Bar.set_Brick(inc_brick)

func pick_chain(item):
	inc_chain = inc_chain + 1
	Panel_Bar.set_Chain(inc_chain)
	
func pick_turrent(item):
	inc_turrent = inc_turrent + 1
	Panel_Bar.set_Turrent(inc_turrent)
	
	
################################# Добавление изначального лута #######################
onready var get_this_item = preload("res://Scenes/Item.tscn")
###Аптека, Гранаты, патроны
func set_item_more(a, b, c):
##########################################################
	a = a + 1
	b = b + 1
	###########################################################
	var items_all_gr = ["Gr"]
	var items_all_am = ["Ammo"]
	var items_all_ap = ["Apteka"]
	var loot_apteka = "Apteka"
	var loot_ammo = "Ammo"
	var loot_gr = "Gr"
	
	#### Аптечка 
	yoy = "Apteka"
	var new_it2 = get_this_item.instance()
	new_it2.set_item(items_all_ap[0])
	tot = new_it2
	for i in range(a):
		inc_apteka = inc_apteka + 1
		if loot_apteka in inventory.keys():  #Если есть в инвентаре
			inventory[loot_apteka] += new_it2.get_amount()
		else:                       #Если нет в инвентаре 
			 inventory[loot_apteka] = new_it2.get_amount()
	#### Граната
	yoy2 = "Gr"
	var new_it = get_this_item.instance()
	new_it.set_item(items_all_gr[0])
	tot2 = new_it
	for i in range(b):
		inc_gr = inc_gr + 1
		if loot_gr in inventory.keys():  #Если есть в инвентаре
			inventory[loot_gr] += new_it.get_amount()
		else:                       #Если нет в инвентаре 
			 inventory[loot_gr] = new_it.get_amount()
	#### Патроны
	yoy1 = "Ammo"
	var new_it1 = get_this_item.instance()
	new_it1.set_item(items_all_am[0])
	tot1 = new_it1
	for i in range(c):
		inc_ammo = inc_ammo + 1
		if loot_ammo in inventory.keys():  #Если есть в инвентаре
			inventory[loot_ammo] += new_it1.get_amount()
		else:                       #Если нет в инвентаре 
			 inventory[loot_ammo] = new_it1.get_amount()
	   ###################################	
	inc_apteka = inc_apteka - 1
	inc_gr = inc_gr - 1
	if yoy2 in inventory.keys():  #Если есть в инвентаре граната, то при использование уменьшаем ее кол-во на 1 в инвентаре 
		inventory[yoy2] -= tot2.get_amount()
	if yoy in inventory.keys():  #Если есть в инвентаре граната, то при использование уменьшаем ее кол-во на 1 в инвентаре 
		inventory[yoy] -= tot.get_amount()
	   ########################################
	ui.update_inventory(inventory)
	
	###Баррикады
func set_item_barricade(a, b, c):
	inc_brick = inc_brick + a
	Panel_Bar.set_Brick(inc_brick)

	inc_chain = inc_chain + b
	Panel_Bar.set_Chain(inc_chain)
	
	inc_turrent = inc_turrent + c
	Panel_Bar.set_Turrent(inc_turrent)
		
###############################################################################
	
	
func _on_AllowShoot_timeout():
	allow_shoot = true
	pass # Replace with function body.


###Таймер для отмены анимации бросания гранаты
func _on_Arm_timeout():
	$Arm_Left.visible = false
	$Arm_Right.visible = false
	$Arm_Down.visible = false
	pass # Replace with function body.
	
	
############################################################# Баррикады (добавление на карту)
const Barricade_1 = preload("res://Scenes/Barr.tscn")
const Barricade_2 = preload("res://Scenes/Barr_L.tscn")
const Barricade_3 = preload("res://Scenes/Barr_U.tscn")
const Barricade_4 = preload("res://Scenes/Barr_R.tscn")

var hoh = null
func Barricade_1put():  ######## Баррикады кирпич 
	if (inc_brick > 0 and Barr1 == true):
		if inc == 4:
				var Barr = Barricade_4.instance()
				Barr.global_position = $Br_R.position + position
				get_parent().add_child(Barr)       
		elif inc == 3:
				var Barr = Barricade_2.instance()
				Barr.global_position = $Br_L.position + position
				get_parent().add_child(Barr) 
		elif inc == 2:
				var Barr = Barricade_1.instance()
				Barr.global_position = $Br_D.position + position
				get_parent().add_child(Barr) 
		elif inc == 1:
				var Barr = Barricade_3.instance()
				Barr.global_position = $Br_U.position + position
				get_parent().add_child(Barr) 
		inc_brick = inc_brick - 1
		Panel_Bar.set_Brick(inc_brick)
			
			
			
const Barricade_6 = preload("res://Scenes/Barr_L_more.tscn")
const Barricade_7 = preload("res://Scenes/Barr_R_more.tscn")
const Barricade_8 = preload("res://Scenes/Barr_D_more.tscn")
const Barricade_9 = preload("res://Scenes/Barr_U_more.tscn")
func Barricade_2put(): ################Баррикады с турелькой 
	if inc_turrent > 0 and Barr3 == true:   
		if inc == 4:
				var Barr = Barricade_7.instance() #7
				Barr.global_position = $Br_R.position + position
				get_parent().add_child(Barr)   
		elif inc == 3:
				var Barr_more_1 = Barricade_6.instance()  #6
				Barr_more_1.global_position = $Br_L.position + position
				get_parent().add_child(Barr_more_1)  
		elif inc == 2:
				var Barr = Barricade_8.instance()  #8
				Barr.global_position = $Br_D.position + position
				get_parent().add_child(Barr) 
		elif inc == 1:
				var Barr = Barricade_9.instance()  #9
				Barr.global_position = $Br_U2.position + position
				get_parent().add_child(Barr) 
		inc_turrent = inc_turrent - 1
		Panel_Bar.set_Turrent(inc_turrent) 
			
const Barricade_10 = preload("res://Scenes/Barr_L_3.tscn")
const Barricade_11 = preload("res://Scenes/Barr_R_3.tscn")
const Barricade_12 = preload("res://Scenes/Barr_D_3.tscn")
const Barricade_14 = preload("res://Scenes/Barr_U_3.tscn")
func Barricade_3put():       ###Баррикады колючие
	if inc_chain > 0 and Barr2 == true:
		if inc == 4:
				var Barr = Barricade_11.instance()
				Barr.global_position = $Br_R.position + position
				get_parent().add_child(Barr)   
		elif inc == 3:
				var Barr_more_1 = Barricade_10.instance()
				Barr_more_1.global_position = $Br_L.position + position
				get_parent().add_child(Barr_more_1) 
		elif inc == 2:
				var Barr = Barricade_12.instance()
				Barr.global_position = $Br_D.position + position
				get_parent().add_child(Barr) 
		elif inc == 1:
				var Barr = Barricade_14.instance()
				Barr.global_position = $Br_U.position + position
				get_parent().add_child(Barr) 
		inc_chain = inc_chain - 1
		Panel_Bar.set_Chain(inc_chain)

##############ПРОВЕРКА МОЖНО ЛИ ПОСТВИТЬ БАРРИКАДУ 1, 2, 3
onready var Barrconnect = get_node("Barrconnect")
#1-------------------
var b = 0
var t = false
func set_b(z):
	b = z
func set_t(n):
	t = n
func set_barr1contact(a1):
	Barrconnect.set_barr1contact(a1)
var ShotAndBarrvalue = true
func ShotAndBarr(f1):   #Если выбрана баррикада для установки, то нельзя стрелять, вставать за турель и кидать гранаты
	ShotAndBarrvalue = f1

var Barr1 = false
func set_Barr1(a1):
	Barr1 = a1
#2----------------------
onready var Barrconnect2 = get_node("Barrconnect2")
var b2 = 0
var t2 = false
func set_b2(z2):
	b2 = z2
func set_t2(n2):
	t2 = n2
func set_barr2contact(a2):
	Barrconnect2.set_barr2contact(a2)
var Barr2 = false
func set_Barr2(a2):
	Barr2 = a2
#3--------------------
onready var Barrconnect3 = get_node("Barrconnect3")
var b3 = 0
var t3 = false
func set_b3(z3):
	b3 = z3
func set_t3(n3):
	t3 = n3
func set_barr3contact(a3):
	Barrconnect3.set_barr3contact(a3)
var Barr3 = false
func set_Barr3(a3):
	Barr3 = a3


#Таймер для продолжения анимации с битой
func _on_Timerlol_timeout():
	lol = false
	varBitaD.bitaon(false)
	varBitaU.bitaon(false)
	varBitaL.bitaon(false)
	varBitaR.bitaon(false)
	pass # Replace with function body.
func _on_Timerloltrue_timeout():
	lol_true = true
	pass # Replace with function body.
	
	
#Функция возращающая значение 
func get_BorB():          #### Функция, которая просто возвращает "player"
	return BitaorBarricada
func get_ShotAndBarr(): 
	return ShotAndBarrvalue
func get_vozleturreli(): 
	return vozleturreli
#ИНформация о том открыта ли дверь у замка (если дверь закрыта и игрок берет баррикаду, то дверь открывается)
var door = false
func set_door(n):
	door = n
	pass
func get_door():
	return door
	pass
#для сейвов
var speedmore = 400
func set_speed(a):
	speed = a + 400
	speedmore = speed

func set_HP(a, b):
	self.hp = a + 100
	self.max_hp = b + 100
	set_start_hp(self.hp, self.max_hp)
	ui1.set_start_hp(self.hp, self.max_hp)
func get_speed():
	return speed
func get_HP():
	return self.hp
func get_MAXHP():
	return self.max_hp
#####Взятие значений найденных предметов
func get_incammo():
	return inc_ammo
func get_incgr():
	return inc_gr
func get_incapteka():
	return inc_apteka
func get_incbrick():
	return inc_brick
func get_incchain():
	return inc_chain
func get_incturrent():
	return inc_turrent

#Таймер который возвращает цвет спрайтов и анимаций после прохождения урона
func _on_REDHPTIMER_timeout():
	$anim.modulate = Color(1, 1, 1, 1)
	$Animated.modulate= Color(1, 1, 1, 1)
	$AnimatedSprite.modulate= Color(1, 1, 1, 1)
	$Arm_Down.modulate= Color(1, 1, 1, 1)
	$Arm_Left.modulate= Color(1, 1, 1, 1)
	$Arm_Right.modulate= Color(1, 1, 1, 1)
	$Turrent.modulate= Color(1, 1, 1, 1)
	$Turrent_R.modulate= Color(1, 1, 1, 1)
	$Turrent_U.modulate= Color(1, 1, 1, 1)
	$Turrent_D.modulate= Color(1, 1, 1, 1)
	$AudioDamage.stop()
	pass # Replace with function body.
"""

var timer4 = 0
func _on_TimerItem_timeout():
	timer4 = timer4 + 1
	if timer4 == 1:
		set_item_more(1,1,0)
		inc_apteka = inc_apteka - 1
		inc_gr = inc_gr - 1
		if yoy2 in inventory.keys():  #Если есть в инвентаре граната, то при использование уменьшаем ее кол-во на 1 в инвентаре 
			inventory[yoy2] -= tot2.get_amount()
		if yoy in inventory.keys():  #Если есть в инвентаре граната, то при использование уменьшаем ее кол-во на 1 в инвентаре 
			inventory[yoy] -= tot.get_amount()
		ui.update_inventory(inventory)
		$TimerItem.stop()
	pass # Replace with function body.
"""


func Damagereal():
		$anim.modulate= Color(1, 0.0, 0.0, 1)
		$Animated.modulate= Color(1, 0.0, 0.0, 1)
		$AnimatedSprite.modulate= Color(1, 0.0, 0.0, 1)
		$Arm_Down.modulate= Color(1, 0.0, 0.0, 1)
		$Arm_Left.modulate= Color(1, 0.0, 0.0, 1)
		$Arm_Right.modulate= Color(1, 0.0, 0.0, 1)
		$Turrent.modulate= Color(1, 0.0, 0.0, 1)
		$Turrent_R.modulate= Color(1, 0.0, 0.0, 1)
		$Turrent_U.modulate= Color(1, 0.0, 0.0, 1)
		$Turrent_D.modulate= Color(1, 0.0, 0.0, 1)
		$AudioDamage.play()
		original_hp = self.hp
		$REDHPTIMER.start(0.3)
