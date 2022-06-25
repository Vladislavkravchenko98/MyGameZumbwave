extends "res://Scripts/Men2D.gd"

var stands = true
var destination = Vector2()
var velocity = Vector2()

var prev_pos = Vector2()

var target = null

var d_speed = 60

func _ready():
	speed = 100
	
func _process(delta):
	if velocity:
		prev_pos = position
		move_and_slide(velocity)
		position.x = clamp(position.x, 0, 10000)
		position.y = clamp(position.y, 0, 10000)
	wander()
	
func searc_for_target():
	var pl = get_parent().get_player()
	if position.distance_to(pl.position) < 200:
		cancel_movement()
		speed = d_speed * 2 if speed == d_speed else speed
		target = pl
		
	else:
		if target:
			cancel_movement()
		target = null
		
	if target:
		set_destination(target.position)

func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	stands = false
	
func cancel_movement():
	velocity = Vector2()
	destination = Vector2()
	speed = d_speed
	$StandingTimer.start(1)
	
func wander():
	var pos = position
	if stands:
		randomize()
		
		var x = int(rand_range(pos.x - 200, pos.x + 200))
		var y = int(rand_range(pos.y - 200, pos.y + 200))
		
		x = clamp(x, 0, 10000)
		y = clamp(y, 0, 10000)
		
		set_destination(Vector2(x, y))
	
	elif velocity != Vector2():
		if pos.distance_to(destination) <= speed:
			cancel_movement()
		elif pos.distance_to(prev_pos) <= 0.6:
			cancel_movement()
	
func _on_StandingTimer_timeout():
	stands = true
	pass # Replace with function body.
