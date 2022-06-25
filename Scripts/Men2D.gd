extends KinematicBody2D

var speed = 200

onready var hp = 50
export var max_hp = 300

func _ready():
	set_start_hp(hp, max_hp)
	pass 

func set_start_hp(hp, max_hp): #Начальные данные для HP
	$HP_bar.value = hp
	$HP_bar.max_value = max_hp

func update_hp():            ##Обновление HP
	$HP_bar.value = hp
	
	
func toggle_hp_bar():                         ###Отключение полоски жизней
	$HP_bar.visible = !$HP_bar.visible
	
func reduce_hp(val):              ###Уменьшение HP
	self.hp -= val
	update_hp()
	
func reduce_hp_more(val):            ###Добавление Hp
	if self.hp + val >= self.max_hp:
		self.hp = self.max_hp
		update_hp()
	else:
		self.hp += val
		update_hp()




