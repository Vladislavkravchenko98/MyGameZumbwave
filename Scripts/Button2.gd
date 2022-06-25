extends Button

var Rus = 0


func _on_Button2_pressed():
	$AudioStreamPlayer.play()
	var data = Fs.load_data('Player_saves.txt')
	Rus = data.Rus
	if Rus == 1:
		get_tree().change_scene("res://Scenes/Shoplvlrus.tscn")
	else:
		get_tree().change_scene("res://Scenes/Shoplvl.tscn")
	pass # Replace with function body.
