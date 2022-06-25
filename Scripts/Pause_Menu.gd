extends Control

var Bestwave = 0
func _ready():
	var data = Fs.load_data('Player_saves.txt')
	if data == null:
		$Label4.text = "0"
	else:
		Bestwave = data.Bestwave
		$Label4.text = str(Bestwave)

func _on_Button_button_up():
	#get_parent().save_level()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	get_tree().paused = false 
