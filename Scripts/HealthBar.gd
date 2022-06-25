extends Control

onready var health_bar = $HealthBar

var max_hpmore = null
func set_start_hp(hp, max_hp): #Начальные данные для HP
	$HealthBar.value = hp
	$HealthBar.max_value = max_hp
	$Label.text = str(hp) + "/" + str(max_hp)
	max_hpmore = max_hp

func update_hp(hp):            ##Обновление HP
	$HealthBar.value = hp
	$Label.text = str(hp) + "/" + str(max_hpmore)


#$Label.text = "COINS/" + str(coins)
