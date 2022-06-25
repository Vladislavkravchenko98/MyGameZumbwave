extends Button

export(String) var scene_to_open



func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")
