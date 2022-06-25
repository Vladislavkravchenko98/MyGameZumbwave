extends Button

#export(String) var scene_to_open

func _on_Buttons_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Scenes/LoadingScene.tscn")
	pass


