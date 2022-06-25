extends Node2D

var item = ""
var amount = 1 ### Лежит один предмет

func set_item(item_name):
	$Sprite.texture = load("res://Sprites/Items/%s.png" % item_name)
	item = item_name
func _ready():
	pass 
	
func get_item():
	return item
	
func get_amount():
	return amount
##Делаем так, чтобы игрок мог поднять этот предмет
func _input(event):
	if event.is_action_pressed("e_click"):
		var pl = get_parent().get_parent().get_player()
		if abs(pl.position.x - position.x) < 78 and abs(pl.position.y - position.y) < 78:
			get_parent().remove_child(self)
			pl.pick(self)
			
