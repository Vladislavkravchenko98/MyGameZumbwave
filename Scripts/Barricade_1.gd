extends StaticBody2D

var hp = 100
var fight = false
func _ready():
	$Timer.start(10)
	pass #
	
#func _process(delta):


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
