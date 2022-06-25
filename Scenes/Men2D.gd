extends KinematicBody2D

var speed = 200
var inc = 0;

func _ready():
   pass # Replace with function body.

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("up"):
		inc = 0
		velocity.y -= speed
		$anim.play("U")
		inc = 1
	elif Input.is_action_pressed("down"):
		inc = 0
		velocity.y += speed
		$anim.play("D")
		inc = 2
	elif Input.is_action_pressed("left"):
		inc = 0
		velocity.x -= speed
		$anim.play("L")
		inc = 3
	elif Input.is_action_pressed("right"):
		inc = 0
		velocity.x += speed
		$anim.play("R")
		inc = 4
	else:
		if inc == 1:
			velocity.x = 0
			velocity.y = 0
			$anim.play("idleU")
		if inc == 2:
			velocity.x = 0
			velocity.y = 0
			$anim.play("idleD")
		if inc == 3:
			velocity.x = 0
			velocity.y = 0
			$anim.play("idleL")
		if inc == 4:
			velocity.x = 0
			velocity.y = 0
			$anim.play("idleR")
		
	move_and_slide(velocity)
	position.x = clamp(position.x, 0, 5000)
	position.y = clamp(position.y, 0, 5000)


