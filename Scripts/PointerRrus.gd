extends TouchScreenButton

func _ready():
	pass # Replace with function body.


func _on_PointerR_released():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Scenes/Shoplvl2rus.tscn")
	pass # Replace with function body.
