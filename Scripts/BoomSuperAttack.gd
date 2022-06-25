extends Area2D

const SPEED = 500
var velocity = Vector2()
var inc = 0


var vel = Vector2.ZERO
var vel1 = Vector2.ZERO
func _ready(): 
	vel = global_position	
	$AnimatedSprite.play("default")
	$TimerEnd.start(0.5)





func _on_TimerEnd_timeout():
	queue_free()
	pass 
