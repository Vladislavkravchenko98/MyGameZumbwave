extends Node2D

func get_player():          #### Функция, которая просто возвращает "player"
	if has_node("Player"):
		return $Player
	else:
		return false
		
func get_barr():
	if has_node("Barr"):
		return $Barr
	else:
		return false

func get_Items():
	return $Items

func _ready():
	pass # Replace with function body.
###########################< ВСЕ ЧТО СВЯЗАНО С УПРАВЛЕНИЕМ >##############################
func _process(delta):
	if Input.is_action_pressed("Shot"):
		if trigger == 1:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.Shot()
		elif trigger == 2:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.Shot_Turrent()

var button = 0
func set_button(a):
	button = a

func _unhandled_input(event):
	if event.is_action_pressed("Alt"):     ###При нажатие на "Альт" исчезают полоски жизней у зомби
		for i in get_tree().get_nodes_in_group(GlobalVars.zombi_group):
			i.toggle_hp_bar()
	#if event.is_action_pressed("Shot"):     ###При нажатие на "Пробел" активируется выстрел
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			#i.Shot()
	
	if event.is_action_pressed("ButtonB"):     ###При нажатие на "B" активируется выброс гранаты, использование аптечки и патронов 
		if button == 1:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.Healthmore()
		elif button == 2:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.Gr()	
		elif button == 3:
			Input.action_press("Health")
		elif button == 4:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.Barricade_1put()
		elif button == 5:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.Barricade_3put()
		elif button == 6:
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.Barricade_2put()
			
	if event.is_action_pressed("Gr"):     ###При нажатие на "G" активируется выброс гранаты
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.Gr()
	if event.is_action_pressed("Health"):     ###При нажатие на "H" используется аптечка
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.Healthmore()
	#if event.is_action_pressed("Barricade_1"):   #Добавление баррикад
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			#i.Barricade_1()
	#if event.is_action_pressed("Barricade_2"):   #Добавление баррикад
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			#i.Barricade_2()
	#if event.is_action_pressed("Barricade_3"):   #Добавление баррикад
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			#i.Barricade_3()
	#if Input.is_action_pressed("Shot_more"):
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			#i.Shot_Turrent()
	#if event.is_action_pressed("Pa"):
			#if get_tree().paused == false:
			#	get_tree().paused = true
			#else:
				#get_tree().paused = false 
			
func update_label(value):
	get_parent().update_label(value)
	
	
var trigger = 1

func trigger_on(value):
	trigger = value
###########################################################################################
#Функция которая убирает лишние для геймплея предметы с карты
func remove_items():
	$Nature/Barr2.visible = false



