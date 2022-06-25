extends Button


func _ready():
	pass # Replace with function body.



func _on_Button_button_up():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	pass # Replace with function body.
