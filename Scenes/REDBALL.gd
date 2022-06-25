extends Node2D

func _ready():
	
	pass 



func _process(delta):
	global_position = get_parent().get_player().global_position
	pass
