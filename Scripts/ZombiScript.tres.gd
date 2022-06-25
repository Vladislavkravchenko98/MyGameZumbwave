extends KinematicBody2D

var speed = 70
var stands = true
var destination = Vector2()var velocity = Vector2()


func _process(delta):
	if velocity:
		move_and_slide(velocity)
		position.x = clamp(position.x, 0, 5000)
		position.y = clamp(position.y, 0, 5000)
	wander()

func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	stands = false
	
func cancel_movement():
	velocity = Vector2()
	destination = Vector2()
	$StandingTimer.start(2)
	
func wander():
	var pos = position
	if stands:
		randomize()
		
		var x = int(rand_range(pos.x - 50, pos.x + 50))
		var y = int(rand_range(pos.x - 50, pos.x + 50))
		
		x = clamp(x, 0, 5000)
		y = clamp(y, 0, 5000)
		
		set_destination(Vector2(x, y))
	
	
	
	

func _on_StandingTimer_timeout():
	stands = true
	pass # Replace with function body.
