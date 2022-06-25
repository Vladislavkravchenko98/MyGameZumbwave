extends Control

func _ready():
	$Label.visible = false
	pass 

var wave = 0
func set_wave(amount):
	$Label.visible = true
	$Label.text = "Teleportation in " + str(amount)
	$Timer.start(2)


func get_wave():
	return wave


