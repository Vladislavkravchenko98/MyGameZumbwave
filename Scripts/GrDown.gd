extends Area2D

const SPEED = 500
var velocity = Vector2()
var inc = 0

var object_z = false  ###Врезалась ли пуля в объект

var vel = Vector2.ZERO
var vel1 = Vector2.ZERO
func _ready(): 
	vel = global_position	
	$Anim.play("default")
	$AnimatedSprite.visible = false

func _physics_process(delta):
	if inc == 1:
			$TimerBoom.start(1)
			#queue_free()
	if $AnimatedSprite.visible == false:
		if object_z == true:             #### Анимация если граната отталкивается от другой коллизии
			if global_position.distance_to(vel1) <= 40:
				velocity.y = -(SPEED * delta)
			else:   
				$Anim.play("idle")
				velocity.x = 0
				velocity.y = 0
				inc = inc + 1
			translate(velocity)
		else:                           #### Анимация для обычной траектории гранаты
			
			if global_position.distance_to(vel) <= 140:
				velocity.y = SPEED * delta
			elif global_position.distance_to(vel) > 140 and global_position.distance_to(vel) <= 160:
				velocity.y = SPEED * delta
			elif global_position.distance_to(vel) > 160 and global_position.distance_to(vel) <= 300:
				$Anim.play("default")
				velocity.y = SPEED * delta
			elif global_position.distance_to(vel) > 300 and global_position.distance_to(vel) <= 449:
				velocity.y = SPEED * delta
			elif global_position.distance_to(vel) > 450:
				$Anim.play("idle")
				velocity.x = 0
				velocity.y = 0
				inc = inc + 1
			translate(velocity)


#Пули исчезают когда врезаются в объект
func _on_Plasma_body_entered(body):
	if "Barr" in body.name:
		var i = 0
	elif "Barr_L" in body.name:
		var i = 0
	elif "Barr_R" in body.name:
		var i = 0
	elif "Barr_U" in body.name:
		var i = 0
	elif "Seeeea" in body.name:
		var i = 0
	else:
		if $Collision.disabled == false:
			if "Zombi" in body.name:
				body.kill_gr()
			if "Player" in body.name:
				body.reduce_hp(50)
				body.Damagereal()
		#queue_free()
		object_z = true
		vel1 = global_position




func _on_TimerBoom_timeout():
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("default")
	$CollisionShape2D.disabled = true
	$Collision.disabled = false
	$TimerEnd.start(0.9)
	pass 


func _on_TimerEnd_timeout():
	queue_free()
	pass 
