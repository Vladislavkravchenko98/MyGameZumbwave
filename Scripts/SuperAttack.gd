extends Node2D



func _ready():
	pass # Replace with function body.


var Boom = preload("res://Scenes/BoomSuperAttack.tscn")   

func Addboom():
	for i in range(20):
		var zm = Boom.instance()
		var a = int(rand_range(300, 2000))
		var b = int(rand_range(300, 1000))
				
		zm.position.x = a
		zm.position.y = b
				
		add_child(zm)
