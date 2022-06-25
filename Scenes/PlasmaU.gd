extends Area2D

var SPEED = null
var velocity = Vector2()
var dalnost_poleta = null

func set_bullet(a, b):
	SPEED = a
	dalnost_poleta = b
	
var vel = Vector2.ZERO
func _ready(): 
	vel= global_position
	load_level()

func _physics_process(delta):
	velocity.y = -(SPEED * delta)
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
		if "Zombi" in body.name:
			body.kill()
		queue_free()

func load_level():
	var data = Fs.load_data('Player_saves.txt')
	SPEED = data.Bulletspeed + 500
	dalnost_poleta = data.Therangeofthebullet + 400
