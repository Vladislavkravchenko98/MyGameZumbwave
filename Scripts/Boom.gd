extends Area2D

const SPEED = 500
var velocity = Vector2()
var inc = 0

var object_z = false  ###Врезалась ли пуля в объект

var vel = Vector2.ZERO
var vel1 = Vector2.ZERO
func _ready(): 
	vel = global_position	
	$AnimatedSprite.play("default")
	#$Collision.disabled = false
	$TimerEnd.start(0.5)



#Пули исчезают когда врезаются в объект
func _on_Boom_body_entered(body):
	if "Barr" in body.name:
		var i = 0
	else:
		if $Collision.disabled == false:
			if "Zombi" in body.name:
				body.kill_gr()
			if "Player" in body.name:
				body.reduce_hp(25)






func _on_TimerEnd_timeout():
	queue_free()
	pass 
