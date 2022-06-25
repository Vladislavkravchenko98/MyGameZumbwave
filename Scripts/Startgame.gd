extends Node2D
onready var ui = get_parent().get_parent().get_parent().get_parent().get_node("UI")   #get_parent().get_node("Root/UI/Control2") 

##Делаем так, чтобы игрок мог при нажатие на "e" мог начать игру



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		ui.turnon_BIGREADBUTTON()
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		ui.turnoff_BIGREADBUTTON()
	pass # Replace with function body.
