extends Control

func _ready():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		print('ДА ТАМ БЫЛО ПУСТО')
	else:
		wave = data.numberofwave

	
	
	$Timer.start(2)
	pass 

var wave = 0
func set_wave(amount):
	
	$Label.visible = true
	wave = wave + amount
	
	UI.New_Best()
	
	if wave >= 2:    ####Если волна больше первой, то супер атака должна ожидать
		UI.NewWaveSuperWait()
	
	if wave >= 10 and wave < 100 :
		$Label.rect_position.x = -450
	elif wave >= 100:
		$Label.rect_position.x = -530
	$Label.text = "WAVE " + str(wave)
	$Timer.start(2)

func set_wavemore(amount1):
	wave = wave + amount1

func get_wave():
	return wave

onready var UI = get_viewport().get_node("Root/UI")
func _on_Timer_timeout():
	$Label.visible = false
	pass 
