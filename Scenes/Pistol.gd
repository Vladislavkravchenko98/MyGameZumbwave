extends Node2D

export var fire_position: PoolVector2Array

onready var green_laser = preload("res://Scenes/Hzhz.tscn")

onready var timer = $Countdown

func _process(delta):
	if _is_ready_to_fire():
		_fire()
		
func _fire():
	timer.start()
	
	for pos in fire_position:
		var laser = green_laser.instance()
		laser.position = owner.position + pos
		add_child(laser)
	
func _is_ready_to_fire() -> bool:
	return timer.is_stopped() and Input.is_action_just_pressed("left_click")
