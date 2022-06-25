extends Area2D

var SPEED = 200
var dalnost_poleta = 1200

func set_bullet(a, b):
	SPEED = a
	dalnost_poleta = b
var velocity = Vector2()

var vel = Vector2.ZERO
func _ready(): 
	vel= global_position

func _physics_process(delta):
	velocity.x = - (SPEED * delta)
	translate(velocity)
	
	if global_position.distance_to(vel) > dalnost_poleta:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

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
	else:
		if "Player" in body.name:
			body.reduce_hp(25)
		queue_free()

