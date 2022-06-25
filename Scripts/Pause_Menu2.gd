extends Control

var Bestwave = 0
func _ready():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		$Label4.text = "0"
	else:
		Rus = data.Rus
		language_switch()
		Bestwave = data.Bestwave
		if Bestwave >= 10 and Bestwave < 100:
			$Label4.rect_position.x = -14
		elif Bestwave >= 100:
			$Label4.rect_position.x = -31
		$Label4.text = str(Bestwave)
		var m = mu.get_muon()
		if m == false:
			$Note.visible = false
			$NoteStop.visible = true
			lol = false

 

func _process(delta):
	if mu.get_muon() == false:
		$Note.visible = false
		$NoteStop.visible = true
		lol = false
	else: 
		$NoteStop.visible = false
		$Note.visible = true
		lol = true


func _on_Button3_released():
	$AudioStreamPlayer.play()
	if Rus == 1:
		$Tutorial2.visible = true
	else:
		$Tutorial1.visible = true
	$Close.visible = true
	pass 


func _on_Close_released():
	$AudioStreamPlayer2.play()
	if $Tutorial1.visible == false:
		$Tutorial1.visible = false
		$Close.visible = false
	else:
		$Tutorial1.visible = false
		$Close.visible = false
		
	if $Tutorial2.visible == false:
		$Tutorial2.visible = false
		$Close.visible = false
	else:
		$Tutorial2.visible = false
		$Close.visible = false
	pass # Replace with function body.

onready var UI = get_viewport().get_node("Root/UI")   ##Тут ссылаемся на интерфейс
func _on_Button4_released():
	$AudioStreamPlayer.play()
	UI.Button_pause()
	pass # Replace with function body.




func _on_Button5_released():
	$AudioStreamPlayer.play()
	UI.save_level()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	get_tree().paused = false 
	pass # Replace with function body.


func _on_Button2_released():
	$AudioStreamPlayer.play()
	if Rus == 1:
		$Options2.visible = true
	else:
		$Options.visible = true
	$Close2.visible = true
	pass # Replace with function body.

var lol = true
#onready var mu = get_viewport().get_node("/root/Singletones/GlobalMusic").count
onready var mu = GlobalMusic
func _on_Music_released():
	$AudioStreamPlayer2.play()
	if lol == true:
		$Note.visible = false
		$NoteStop.visible = true
		lol = false
		mu.MusicStop(lol)
	else:
		$NoteStop.visible = false
		$Note.visible = true
		lol = true
		mu.MusicStop(lol)
	
	pass # Replace with function body.


func _on_Close2_released():
	$AudioStreamPlayer2.play()
	if $Options.visible == true or $Options2.visible == true:
		$Options.visible = false
		$Options2.visible = false
		$Close2.visible = false
		
func BestRecordNew(gog):
	$Label4.text = str(gog)
	
var Rus = null
func language_switch():
	if Rus == 1:
		$Label.visible = false
		$Button4/Label.visible = false
		$Button5/Label.visible = false
		$Button5/Label2.visible = false
		$Button2/Label9.visible = false
		$Button3/Label10.visible = false
	
		$Labelrus.visible = true
		$Button4/Labelrus.visible = true
		$Button5/Labelrus.visible = true
		$Button5/Label2rus.visible = true
		$Button5/Label3rus.visible = true
		$Button2/Label9rus.visible = true
		$Button3/Label10rus.visible = true
	else:
		$Labelrus.visible = false
		$Button4/Labelrus.visible = false
		$Button5/Labelrus.visible = false
		$Button5/Label2rus.visible = false
		$Button5/Label3rus.visible = false
		$Button2/Label9rus.visible = false
		$Button3/Label10rus.visible = false
		
		$Label.visible = true
		$Button4/Label.visible = true
		$Button5/Label.visible = true
		$Button5/Label2.visible = true
		$Button2/Label9.visible = true
		$Button3/Label10.visible = true
		
